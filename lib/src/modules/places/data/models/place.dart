import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:hawi_hub_owner/generated/l10n.dart';
import 'package:hawi_hub_owner/src/modules/places/data/models/day.dart';
import 'package:hawi_hub_owner/src/modules/places/data/models/feedback.dart';
import 'package:hawi_hub_owner/src/modules/places/data/models/place_edit_form.dart';
import 'package:hawi_hub_owner/src/modules/places/data/models/place_location.dart';

enum Gender {
  male(0),
  female(1),
  both(2);

  final int value;

  const Gender(this.value);
}

extension gendersName on Gender {
  String genderName(BuildContext context) {
    switch (this) {
      case Gender.male:
        return S.of(context).males;
        ;
      case Gender.female:
        return S.of(context).females;
      case Gender.both:
        return S.of(context).bothMalesAndFemales;
    }
  }
}

// ignore: must_be_immutable
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
  bool isShared;
  int citId;
  Gender availableGender;
  double deposit;

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
    this.isShared = true,
    this.availableGender = Gender.both,
    this.deposit = 0,
  });

  factory Place.fromJson(Map<String, dynamic> json) {
    List openTimesList = json["openTimes"];
    (openTimesList);
    List<Day> days = [];
    for (var element in openTimesList) {
      days.add(Day.fromJson(element));
    }
    print(json);
    return Place(
      citId: json['cityId'],
      id: json['stadiumId'],
      name: json['name'] ?? "",
      description: json['description'] ?? "",
      address: json['address'] ?? "",
      images: List<String>.from(json['images'].map((x) => x['stadiumImageUrl']))
          .toList(),
      ownerId: json['ownerId'] ?? 0,
      minimumHours: json['minHoursReservation'] ?? 0,
      price: json['pricePerHour'] ?? 0,
      totalGames: json['totalGames'] ?? 0,
      totalRatings: json['totalRatings'] ?? 0,
      rating: json['rating'] ?? 0,
      feedbacks: const [],
      workingHours:
          List<Day>.from(json["openTimes"].map((x) => Day.fromJson(x))),
      location: json['location'] == null
          ? null
          : PlaceLocation.fromString(json['location']),
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
        deposit: deposit,
        genders: availableGender,
        isShared: isShared);
  }

  void updatePlace(PlaceEditForm newPlace) {
    name = newPlace.name;
    address = newPlace.address;
    description = newPlace.description;
    images = newPlace.images;
    location = newPlace.location;
    minimumHours = newPlace.minimumHours;
    workingHours = newPlace.workingHours;
    sport = newPlace.sport;
    price = newPlace.price;
    ownerId = newPlace.ownerId;
    citId = newPlace.cityId;
    deposit = newPlace.deposit;
    availableGender = newPlace.genders;
    isShared = newPlace.isShared;
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
