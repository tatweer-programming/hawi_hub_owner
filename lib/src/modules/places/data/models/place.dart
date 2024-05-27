import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hawi_hub_owner/src/core/apis/api.dart';
import 'package:hawi_hub_owner/src/modules/places/data/models/day.dart';
import 'package:hawi_hub_owner/src/modules/places/data/models/feedback.dart';
import 'package:hawi_hub_owner/src/modules/places/data/models/place_edit_form.dart';
import 'package:hawi_hub_owner/src/modules/places/data/models/place_location.dart';

class Place extends Equatable {
  int id;
  String name;
  String address;
  List<Day>? workingHours; // int day, String startTime, String endTime
  PlaceLocation? location; // String longitude, String latitude
  String? description;
  int sport;
  double price;
  int ownerId;
  double? minimumHours;
  List<String> images;
  int totalGames;
  int totalRatings;
  double? rating;
  List<AppFeedBack>? feedbacks;

  int citId;
  int approvalStatus;
  Place({
    required this.id,
    required this.name,
    required this.address,
    this.workingHours,
    this.location,
    this.description,
    required this.sport,
    required this.price,
    required this.ownerId,
    this.minimumHours,
    required this.images,
    required this.totalGames,
    required this.totalRatings,
    this.rating,
    this.feedbacks,
    required this.citId,
    this.approvalStatus = 0,
  });

  factory Place.fromJson(Map<String, dynamic> json) {
    List openTimesList = json["openTimes"];
    (openTimesList);
    List<Day> days = [];
    openTimesList.forEach((element) {
      //print(Day.fromJson(element));
      days.add(Day.fromJson(element));
    });
    print(json);
    return Place(
      citId: json['cityId'],
      id: json['stadiumId'],
      name: json['name'] ?? "",
      description: json['description'] ?? "",
      address: json['address'] ?? "",
      images: List<String>.from(
          json['images'].map((x) => ApiManager.handleImageUrl(x['stadiumImageUrl']))).toList(),
      // images: const [
      //   "https://images.pexels.com/photos/46798/the-ball-stadion-football-the-pitch-46798.jpeg?auto=compress&cs=tinysrgb&w=400",
      //   "https://images.pexels.com/photos/399187/pexels-photo-399187.jpeg?auto=compress&cs=tinysrgb&w=400",
      //   "https://images.pexels.com/photos/61135/pexels-photo-61135.jpeg?auto=compress&cs=tinysrgb&w=400"
      // ],
      /*
       */
      ownerId: json['ownerId'] ?? 0,
      minimumHours: json['minHoursReservation'] ?? 0,
      price: json['pricePerHour'] ?? 0,
      totalGames: json['totalGames'] ?? 0,
      totalRatings: json['totalRatings'] ?? 0,
      rating: json['rating'] ?? 0,
      feedbacks: [],
      workingHours: List<Day>.from(json["openTimes"].map((x) => Day.fromJson(x))),
      location: json['location'] == null ? null : PlaceLocation.fromString(json['location']),
      sport: json['categoryId'] ?? 0,
      approvalStatus: json['approvalStatus'] ?? 0,
    );
  }

  static List<Day> getWeekDays(List<Map<String, dynamic>> weekDays) {
    List<Day> days = [];
    for (var element in weekDays) {
      days.add(Day.fromJson(element));
    }
    return days;
  }

  PlaceEditForm createEditForm() {
    List<String> modifiableImages = [];
    for (var image in images) {
      modifiableImages.add(image);
    }
    print("images : $images");
    return PlaceEditForm(
      name: name,
      address: address,
      description: description,
      images: [...images],
      location: location,
      minimumHours: minimumHours,
      workingHours: workingHours!,
      sport: sport,
      price: price,
      ownerId: ownerId,
      imageFiles: [],
      cityId: citId,
    );
  }

  bool isBookingAllowed(DateTime startTime, DateTime endTime) {
    // get day index
    // check if time is in working hours
    int dayIndex = getDayIndex(startTime);
    return workingHours![dayIndex].isBookingAllowed(startTime, endTime);
  }

  int getDayIndex(DateTime startTime) {
    switch (startTime.weekday) {
      case DateTime.sunday:
        return 0;
      case DateTime.monday:
        return 1;
      case DateTime.tuesday:
        return 2;
      case DateTime.wednesday:
        return 3;
      case DateTime.thursday:
        return 4;
      case DateTime.friday:
        return 5;
      default:
        return 6;
    }
  }

  @override
  List<Object?> get props => [];
}
