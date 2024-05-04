import 'dart:io';

import 'package:dio/dio.dart';
import 'package:hawi_hub_owner/src/modules/places/data/models/day.dart';
import 'package:hawi_hub_owner/src/modules/places/data/models/place_location.dart';

class PlaceEditForm {
  String name;
  String address;
  List<Day> workingHours; // int day, String startTime, String endTime  ///
  PlaceLocation? location; // String longitude, String latitude
  String? description;
  String sport;
  double price;

  ///
  int ownerId;
  double? minimumHours;

  ///
  List<String> images;
  List<File> imageFiles;

  ///
  int cityId;
  PlaceEditForm({
    required this.name,
    required this.address,
    required this.workingHours,
    this.location,
    this.description,
    required this.sport,
    required this.price,
    required this.ownerId,
    this.minimumHours,
    required this.imageFiles,
    required this.cityId,
    required this.images,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'address': address,
      'description': description,
      'sport_id': sport,
      'price': price,
      'owner_id': ownerId,
      'minimum_hours': minimumHours,
      'location': location?.toStr(),
      'deletedImages': images,
      "working_hours": workingHours.map((e) => e.toJson()).toList()
    };
  }

  FormData toFormData() {
    //  Unit8List image = await ownershipFile.readAsBytes();
    return FormData.fromMap({
      "city_id": cityId,
      "owner_id": ownerId,
      "name": name,
      "address": address,
      "open_times": workingHours
          .map((workingHour) => {
                'day_of_week': workingHour.dayOfWeek,
                'start_time': '${workingHour.startTime.hour}:${workingHour.startTime.minute}:00',
                'end_time': '${workingHour.endTime.hour}:${workingHour.endTime.minute}:00',
              })
          .toList(),
      "location": location?.toStr(),
      "category": sport,
      "description": description,
      "price_per_hour": price,
      "min_hours_reservation": minimumHours,
      "images": images,
      "new_images": imageFiles,
    });
  }
}
