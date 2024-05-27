import 'dart:io';
import 'package:hawi_hub_owner/src/modules/places/data/models/day.dart';
import 'package:hawi_hub_owner/src/modules/places/data/models/place_location.dart';

class PlaceCreationForm {
  String name;
  String address;
  List<Day> workingHours; // int day, String startTime, String endTime  ///
  PlaceLocation? location; // String longitude, String latitude
  String? description;
  int sportId;
  double price;

  ///
  int ownerId;
  int? minimumHours;

  ///
  List<String>? images;
  List<File> imageFiles;

  ///
  File ownershipFile;
  String? ownershipUrl;
  int cityId;

  void setAttachments(List<String> images, String ownershipUrl) {
    this.images = images;
    this.ownershipUrl = ownershipUrl;
  }

  PlaceCreationForm({
    required this.name,
    required this.address,
    required this.workingHours,
    this.location,
    this.description,
    required this.sportId,
    required this.price,
    required this.ownerId,
    this.minimumHours,
    required this.imageFiles,
    required this.ownershipFile,
    required this.cityId,
  });
  Map<String, dynamic> toJson() {
    return {
      "cityId": cityId,
      "ownerId": ownerId,
      "name": name,
      'address': address,
      "openTimes": workingHours.map((e) => e.toJson()).toList(),
      "location": location?.toStr(),
      "categoryId": sportId,
      "description": description,
      "pricePerHour": price,
      "minHoursReservation": minimumHours,
      "proofOfOwnershipUrl": ownershipUrl,
      "imagesUrl": images,
    };
  }
}
