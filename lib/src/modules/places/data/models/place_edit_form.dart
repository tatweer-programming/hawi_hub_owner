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
  int? minimumHours;

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
      "dto.CityId": cityId,
      "dto.OwnerId": ownerId,
      "dto.Name": name,
      'dto.Address': address,
      "dto.OpenTimes[0].DayOfWeek": 0,
      "dto.OpenTimes[0].StartTime":
          "${workingHours[0].startTime.hour}:${workingHours[0].startTime.minute}:00",
      "dto.OpenTimes[0].EndTime":
          "${workingHours[0].endTime.hour}:${workingHours[0].endTime.minute}:00",
      "dto.OpenTimes[1].DayOfWeek": 1,
      "dto.OpenTimes[1].StartTime":
          "${workingHours[1].startTime.hour}:${workingHours[1].startTime.minute}:00",
      "dto.OpenTimes[1].EndTime":
          "${workingHours[1].endTime.hour}:${workingHours[1].endTime.minute}:00",
      "dto.OpenTimes[2].DayOfWeek": 2,
      "dto.OpenTimes[2].StartTime":
          "${workingHours[2].startTime.hour}:${workingHours[2].startTime.minute}:00",
      "dto.OpenTimes[2].EndTime":
          "${workingHours[2].endTime.hour}:${workingHours[2].endTime.minute}:00",
      "dto.OpenTimes[3].DayOfWeek": 3,
      "dto.OpenTimes[3].StartTime":
          "${workingHours[3].startTime.hour}:${workingHours[3].startTime.minute}:00",
      "dto.OpenTimes[3].EndTime":
          "${workingHours[3].endTime.hour}:${workingHours[3].endTime.minute}:00",
      "dto.OpenTimes[4].DayOfWeek": 4,
      "dto.OpenTimes[4].StartTime":
          "${workingHours[4].startTime.hour}:${workingHours[4].startTime.minute}:00",
      "dto.OpenTimes[4].EndTime":
          "${workingHours[4].endTime.hour}:${workingHours[4].endTime.minute}:00",
      "dto.OpenTimes[5].DayOfWeek": 5,
      "dto.OpenTimes[5].StartTime":
          "${workingHours[5].startTime.hour}:${workingHours[5].startTime.minute}:00",
      "dto.OpenTimes[5].EndTime":
          "${workingHours[5].endTime.hour}:${workingHours[5].endTime.minute}:00",
      "dto.OpenTimes[6].DayOfWeek": 6,
      "dto.OpenTimes[6].StartTime":
          "${workingHours[6].startTime.hour}:${workingHours[6].startTime.minute}:00",
      "dto.OpenTimes[6].EndTime":
          "${workingHours[6].endTime.hour}:${workingHours[6].endTime.minute}:00",
      "dto.Location": location?.toStr(),
      "dto.Category": sport,
      "dto.Description": description,
      "dto.PricePerHour": price,
      "dto.MinHoursReservation": minimumHours,
      "dto.ImagesFiles": imageFiles.map((e) => MultipartFile.fromFileSync(e.path)).toList(),
      "dto.Images": images
    });
  }
// Future<FormData> toFormData() async {
//   var formData = FormData();
//   formData.fields.add(MapEntry('Name', name));
//   formData.fields.add(MapEntry('Address', address));
//   formData.fields
//       .add(MapEntry('OpenTimes', )));
//   formData.fields.add(MapEntry('Category', sport));
//   formData.fields.add(MapEntry('Description', description ?? ''));
//   formData.fields.add(MapEntry('PricePerHour', price.toString()));
//   formData.fields.add(MapEntry('MinHoursReservation', minimumHours.toString()));
//   formData.fields.add(MapEntry('OwnerId', ownerId.toString()));
//   formData.fields.add(MapEntry('CityId', cityId.toString()));
//
//   if (location != null) {
//     // Add location data based on your Location model (assuming it has toStr())
//     formData.fields.add(MapEntry('Location', location!.toStr()));
//   }
//
//   // Add ProofOfOwnershipFile
//   var ownershipBytes = await ownershipFile.readAsBytes();
//   formData.files.add(MapEntry(
//       'ProofOfOwnershipFile',
//       MultipartFile.fromBytes(
//         ownershipBytes,
//         filename: ownershipFile.path.split('/').last,
//       )));
//
//   // Add Images
//   for (var file in imageFiles) {
//     var bytes = await file.readAsBytes();
//     formData.files.add(MapEntry(
//         'Images[]',
//         MultipartFile.fromBytes(
//           bytes,
//           filename: file.path.split('/').last,
//         )));
//   }
//   print("LLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLL");
//   print(formData);
//   formData.finalize();
//   return formData;
// }
// //
}
