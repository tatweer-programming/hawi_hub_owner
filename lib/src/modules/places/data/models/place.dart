
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hawi_hub_owner/src/modules/places/data/models/day.dart';
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
  int? minimumHours;
  List<String> images;
  int totalGames;
  int totalRatings;
  double? rating;
  List<Feedback>? feedbacks;
  String ownerName;
  String ownerImageUrl;
  int citId;
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
  });

  factory Place.fromJson(Map<String, dynamic> json) {
    return Place(
      citId: json['city_id'],
      id: json['id'],
      name: json['name'],
      description: json['description'],
      address: json['address'],
      images: json['images'],
      ownerId: json['owner_id'],
      minimumHours: json['minimum_hours'],
      price: json['price'],
      totalGames: json['total_games'],
      totalRatings: json['total_ratings'],
      ownerName: json['owner_name'],
      ownerImageUrl: json['owner_image_url'],
      rating: json['rating'],
      feedbacks: json['feedbacks'],
      workingHours: List<Day>.from(
        json['working_hours'].map((x) => Day.fromJson(x)),
      ),
      location: PlaceLocation.fromString(json['location']),
      sport: json['sport_id'],
    );
  }

  static List<Day> getWeekDays(Map<int, List<TimeOfDay>> weekDays) {
    List<Day> days = [];
    for (var element in weekDays.entries) {
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
