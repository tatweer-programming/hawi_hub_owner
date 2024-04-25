import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:hawi_hub_owner/src/modules/places/data/models/day.dart';
import 'package:hawi_hub_owner/src/modules/places/data/models/place_location.dart';

class PlaceCreationForm {
  String name;
  String address;
  List<Day> workingHours; // int day, String startTime, String endTime
  PlaceLocation? location; // String longitude, String latitude
  String? description;
  String sport;
  double price;
  int ownerId;
  int? minimumHours;
  List<String>? images;
  List<File> imageFiles;
  File ownershipFile;
  int cityId;
  PlaceCreationForm({
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
    required this.ownershipFile,
    required this.cityId,
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
      'location': location?.toJson(),
      'images': images,
      "working_hours": workingHours?.map((e) => e.toJson()).toList()
    };
  }

  setImages(List<String> images) {
    this.images = images;
  }

  FormData toFormData() {
    //  Unit8List image = await ownershipFile.readAsBytes();
    List<int> imageBytes = ownershipFile.readAsBytesSync();
    print(imageBytes);
    String base64ownership = base64Encode(imageBytes);
    List<String> base64Images = imageFiles.map((e) => base64Encode(e.readAsBytesSync())).toList();
    return FormData.fromMap({
      'Name': name,
      'Address': address,
      'OpenTimes': workingHours,
      "OwnerId ": ownerId,
      "Location": location?.toJson(),
      "Category": sport,
      "Description": description,
      "PricePerHour": price,
      "MinHoursReservation": minimumHours,
      "ProofOfOwnershipFile": base64ownership,
      "Images": base64Images,
    });
  }
}
