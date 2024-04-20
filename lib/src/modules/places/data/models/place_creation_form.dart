import 'dart:io';

import 'package:hawi_hub_owner/src/modules/places/data/models/day.dart';
import 'package:hawi_hub_owner/src/modules/places/data/models/place_location.dart';

class PlaceCreationForm {
  String name;
  String address;
  List<Day>? workingHours; // int day, String startTime, String endTime
  PlaceLocation? location; // String longitude, String latitude
  String? description;
  int sportId;
  double price;
  int ownerId;
  int? minimumHours;
  List<String> images;
  List<File> imageFiles;

  PlaceCreationForm({
    required this.name,
    required this.address,
    required this.workingHours,
    required this.location,
    required this.description,
    required this.sportId,
    required this.price,
    required this.ownerId,
    required this.minimumHours,
    this.images = const [],
    required this.imageFiles,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'address': address,
      'description': description,
      'sport_id': sportId,
      'price': price,
      'owner_id': ownerId,
      'minimum_hours': minimumHours,
      'location': location?.toJson(),
      'images': images,
      "working_hours": workingHours?.map((e) => e.toJson()).toList()
    };
  }

  setImages(List<String> images) {
    this.images = images;
  }
}
