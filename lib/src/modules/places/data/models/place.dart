import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
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
  String sport;
  double price;
  int ownerId;
  double? minimumHours;
  List<String> images;
  int totalGames;
  int totalRatings;
  double? rating;
  List<Feedback>? feedbacks;
  String ownerName;
  String ownerImageUrl;
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
    required this.ownerName,
    required this.ownerImageUrl,
    required this.citId,
    this.approvalStatus = 0,
  });

  factory Place.fromJson(Map<String, dynamic> json) {
    return Place(
      citId: json['cityId'],
      id: json['stadiumId'],
      name: json['name'],
      description: json['description'],
      address: json['address'],
      images: [],
      ownerId: json['ownerId'],
      minimumHours: json['minHoursReservation'],
      price: json['pricePerHour'],
      totalGames: json['totalGames'] ?? 0,
      totalRatings: json['totalRatings'] ?? 0,
      ownerName: json['ownerName'] ?? '',
      ownerImageUrl: json['ownerImageUrl'] ?? '',
      rating: json['rating'] ?? 0.0,
      feedbacks: [],
      workingHours: List<Day>.from(
        json['openTimes'].map((x) => Day.fromJson(x)),
      ),
      location: PlaceLocation.fromString(json['location']),
      sport: json['category'],
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
    return PlaceEditForm(
      name: name,
      address: address,
      description: description,
      images: modifiableImages,
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

  @override
  List<Object?> get props => [];
}
