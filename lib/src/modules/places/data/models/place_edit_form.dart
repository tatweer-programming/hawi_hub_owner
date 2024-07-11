import 'dart:io';
import 'package:hawi_hub_owner/src/core/apis/api.dart';
import 'package:hawi_hub_owner/src/modules/places/data/models/day.dart';
import 'package:hawi_hub_owner/src/modules/places/data/models/place_location.dart';

class PlaceEditForm {
  String name;
  String address;
  List<Day> workingHours; // int day, String startTime, String endTime  ///
  PlaceLocation? location; // String longitude, String latitude
  String? description;
  int sport;
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
    print("name: $name , \n address: $address , \n sport: $sport , \n price: $price ,"
        " \n ownerId: $ownerId ,"
        " \n minimumHours: $minimumHours , \n imageFiles: $imageFiles , \n cityId: $cityId , \n images: $images");
    return {
      // "cityId": cityId,
      // "ownerId": ownerId,
      "name": name,
      'address': address,
      "openTimes": workingHours.map((e) => e.toJson()).toList(),
      "location": location?.toStr(),
      // "categoryId": sport,
      "description": description,
      "pricePerHour": price,
      "minHoursReservation": minimumHours,
      "imagesUrl": images, // images,
    };
  }

  void updateImages(List<String> images) {
    this.images = images.map((e) => ApiManager.convertUrlToPath(e)).toList();
  }
}
