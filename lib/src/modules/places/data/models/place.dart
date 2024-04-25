import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hawi_hub_owner/src/modules/places/data/models/day.dart';
import 'package:hawi_hub_owner/src/modules/places/data/models/feedback.dart';
import 'package:hawi_hub_owner/src/modules/places/data/models/place_location.dart';

class Place extends Equatable {
  int id;
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
  int totalGames;
  int totalRatings;
  double? rating;
  List<Feedback>? feedbacks;
  String ownerName;
  String ownerImageUrl;

  Place({
    required this.id,
    required this.name,
    required this.address,
    this.workingHours,
    this.location,
    this.description,
    required this.sportId,
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
  });

  factory Place.fromJson(Map<String, dynamic> json) {
    return Place(
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
      sportId: json['sport_id'],
    );
  }

  static List<Day> getWeekDays(Map<int, List<int>> weekDays) {
    List<Day> days = [];
    weekDays.entries.forEach((element) {
      days.add(Day.fromJson(element));
    });
    return days;
  }

  Place createCopy() {
    return Place(
      id: id,
      name: name,
      description: description,
      address: address,
      images: images,
      ownerId: ownerId,
      minimumHours: minimumHours,
      price: price,
      totalGames: totalGames,
      totalRatings: totalRatings,
      rating: rating,
      feedbacks: feedbacks,
      ownerName: ownerName,
      ownerImageUrl: ownerImageUrl,
      location: location,
      sportId: sportId,
      workingHours: workingHours,
    );
  }

  @override
  List<Object?> get props => [];
}
