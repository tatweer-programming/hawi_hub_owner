import 'package:flutter/material.dart';
import 'package:hawi_hub_owner/src/modules/places/data/models/day.dart';
import 'package:hawi_hub_owner/src/modules/places/data/models/place_location.dart';

import '../models/place.dart';

List<Place> dummyPlaces = [
  Place(
    totalGames: 122,
    totalRatings: 90,
    rating: 3.5,
    address: "Cairo - Borg El Arab Desert Road, Amreya - Alexandria Egypt",
    ownerId: 1,
    name: "Borg El Arab",
    description: "Borg El Arab is the most beautiful stadium in Egypt for football",
    images: const [
      "https://images.pexels.com/photos/46798/the-ball-stadion-football-the-pitch-46798.jpeg?auto=compress&cs=tinysrgb&w=400",
      "https://images.pexels.com/photos/399187/pexels-photo-399187.jpeg?auto=compress&cs=tinysrgb&w=400",
      "https://images.pexels.com/photos/61135/pexels-photo-61135.jpeg?auto=compress&cs=tinysrgb&w=400"
    ],
    id: 1,
    price: 300,
    minimumHours: 2,
    location: PlaceLocation(latitude: 31.333333333, longitude: 30.333333333),
    sport: "",
    workingHours: const [
      Day(
        dayOfWeek: 0,
        endTime: TimeOfDay(hour: 23, minute: 59),
        startTime: TimeOfDay(hour: 00, minute: 00),
      ),
      Day(
        dayOfWeek: 1,
        endTime: TimeOfDay(hour: 23, minute: 59),
        startTime: TimeOfDay(hour: 00, minute: 00),
      ),
      Day(
        dayOfWeek: 2,
        endTime: TimeOfDay(hour: 23, minute: 59),
        startTime: TimeOfDay(hour: 00, minute: 00),
      ),
      Day(
        dayOfWeek: 3,
        endTime: TimeOfDay(hour: 23, minute: 59),
        startTime: TimeOfDay(hour: 00, minute: 00),
      ),
      Day(
        dayOfWeek: 4,
        endTime: TimeOfDay(hour: 23, minute: 59),
        startTime: TimeOfDay(hour: 00, minute: 00),
      ),
      Day(
        dayOfWeek: 5,
        endTime: TimeOfDay(hour: 23, minute: 59),
        startTime: TimeOfDay(hour: 00, minute: 00),
      ),
      Day(
        dayOfWeek: 6,
        endTime: TimeOfDay(hour: 23, minute: 59),
        startTime: TimeOfDay(hour: 00, minute: 00),
      ),
    ],
    citId: 2,
  ),
  Place(
    totalGames: 122,
    totalRatings: 90,
    rating: 3.5,
    address: "Cairo - Borg El Arab Desert Road, Amreya - Alexandria Egypt",
    ownerId: 1,
    name: "Borg El Arab",
    description: "Borg El Arab is the most beautiful stadium in Egypt for football",
    images: const [
      "https://images.pexels.com/photos/46798/the-ball-stadion-football-the-pitch-46798.jpeg?auto=compress&cs=tinysrgb&w=400",
      "https://images.pexels.com/photos/399187/pexels-photo-399187.jpeg?auto=compress&cs=tinysrgb&w=400",
      "https://images.pexels.com/photos/61135/pexels-photo-61135.jpeg?auto=compress&cs=tinysrgb&w=400"
    ],
    id: 1,
    price: 300,
    minimumHours: 2,
    location: PlaceLocation(latitude: 31.333333333, longitude: 30.333333333),
    sport: "",
    workingHours: const [
      Day(
        dayOfWeek: 0,
        endTime: TimeOfDay(hour: 23, minute: 59),
        startTime: TimeOfDay(hour: 00, minute: 00),
      ),
      Day(
        dayOfWeek: 1,
        endTime: TimeOfDay(hour: 23, minute: 59),
        startTime: TimeOfDay(hour: 00, minute: 00),
      ),
      Day(
        dayOfWeek: 2,
        endTime: TimeOfDay(hour: 23, minute: 59),
        startTime: TimeOfDay(hour: 00, minute: 00),
      ),
      Day(
        dayOfWeek: 3,
        endTime: TimeOfDay(hour: 23, minute: 59),
        startTime: TimeOfDay(hour: 00, minute: 00),
      ),
      Day(
        dayOfWeek: 4,
        endTime: TimeOfDay(hour: 23, minute: 59),
        startTime: TimeOfDay(hour: 00, minute: 00),
      ),
      Day(
        dayOfWeek: 5,
        endTime: TimeOfDay(hour: 23, minute: 59),
        startTime: TimeOfDay(hour: 00, minute: 00),
      ),
      Day(
        dayOfWeek: 6,
        endTime: TimeOfDay(hour: 23, minute: 59),
        startTime: TimeOfDay(hour: 00, minute: 00),
      ),
    ],
    citId: 2,
  ),
  Place(
    totalGames: 122,
    totalRatings: 90,
    rating: 3.5,
    address: "Cairo - Borg El Arab Desert Road, Amreya - Alexandria Egypt",
    ownerId: 1,
    name: "Borg El Arab",
    description: "Borg El Arab is the most beautiful stadium in Egypt for football",
    images: const [
      "https://images.pexels.com/photos/46798/the-ball-stadion-football-the-pitch-46798.jpeg?auto=compress&cs=tinysrgb&w=400",
      "https://images.pexels.com/photos/399187/pexels-photo-399187.jpeg?auto=compress&cs=tinysrgb&w=400",
      "https://images.pexels.com/photos/61135/pexels-photo-61135.jpeg?auto=compress&cs=tinysrgb&w=400"
    ],
    id: 1,
    price: 300,
    minimumHours: 2,
    location: PlaceLocation(latitude: 31.333333333, longitude: 30.333333333),
    sport: "",
    workingHours: const [
      Day(
        dayOfWeek: 1,
        startTime: TimeOfDay(hour: 12, minute: 0),
        endTime: TimeOfDay(hour: 23, minute: 59),
      )
    ],
    citId: 2,
  ),
  Place(
    citId: 2,
    totalGames: 122,
    totalRatings: 90,
    rating: 3.5,
    address: "Cairo - Borg El Arab Desert Road, Amreya - Alexandria Egypt",
    ownerId: 1,
    name: "Borg El Arab",
    description: "Borg El Arab is the most beautiful stadium in Egypt for football",
    images: const [
      "https://images.pexels.com/photos/46798/the-ball-stadion-football-the-pitch-46798.jpeg?auto=compress&cs=tinysrgb&w=400",
      "https://images.pexels.com/photos/399187/pexels-photo-399187.jpeg?auto=compress&cs=tinysrgb&w=400",
      "https://images.pexels.com/photos/61135/pexels-photo-61135.jpeg?auto=compress&cs=tinysrgb&w=400"
    ],
    id: 1,
    price: 300,
    minimumHours: 2,
    location: PlaceLocation(latitude: 31.333333333, longitude: 30.333333333),
    sport: "",
    workingHours: const [
      Day(
        dayOfWeek: 0,
        endTime: TimeOfDay(hour: 23, minute: 59),
        startTime: TimeOfDay(hour: 00, minute: 00),
      ),
      Day(
        dayOfWeek: 1,
        endTime: TimeOfDay(hour: 23, minute: 59),
        startTime: TimeOfDay(hour: 00, minute: 00),
      ),
      Day(
        dayOfWeek: 2,
        endTime: TimeOfDay(hour: 23, minute: 59),
        startTime: TimeOfDay(hour: 00, minute: 00),
      ),
      Day(
        dayOfWeek: 3,
        endTime: TimeOfDay(hour: 23, minute: 59),
        startTime: TimeOfDay(hour: 00, minute: 00),
      ),
      Day(
        dayOfWeek: 4,
        endTime: TimeOfDay(hour: 23, minute: 59),
        startTime: TimeOfDay(hour: 00, minute: 00),
      ),
      Day(
        dayOfWeek: 5,
        endTime: TimeOfDay(hour: 23, minute: 59),
        startTime: TimeOfDay(hour: 00, minute: 00),
      ),
      Day(
        dayOfWeek: 6,
        endTime: TimeOfDay(hour: 23, minute: 59),
        startTime: TimeOfDay(hour: 00, minute: 00),
      ),
    ],
  ),
  Place(
    citId: 1,
    totalGames: 122,
    totalRatings: 90,
    rating: 3.5,
    address: "Cairo - Borg El Arab Desert Road, Amreya - Alexandria Egypt",
    ownerId: 1,
    name: "Borg El Arab",
    description: "Borg El Arab is the most beautiful stadium in Egypt for football",
    images: const [
      "https://images.pexels.com/photos/46798/the-ball-stadion-football-the-pitch-46798.jpeg?auto=compress&cs=tinysrgb&w=400",
      "https://images.pexels.com/photos/399187/pexels-photo-399187.jpeg?auto=compress&cs=tinysrgb&w=400",
      "https://images.pexels.com/photos/61135/pexels-photo-61135.jpeg?auto=compress&cs=tinysrgb&w=400"
    ],
    id: 1,
    price: 300,
    minimumHours: 2,
    location: PlaceLocation(latitude: 31.333333333, longitude: 30.333333333),
    sport: "",
    workingHours: const [
      Day(
        dayOfWeek: 0,
        endTime: TimeOfDay(hour: 23, minute: 59),
        startTime: TimeOfDay(hour: 00, minute: 00),
      ),
      Day(
        dayOfWeek: 1,
        endTime: TimeOfDay(hour: 23, minute: 59),
        startTime: TimeOfDay(hour: 00, minute: 00),
      ),
      Day(
        dayOfWeek: 2,
        endTime: TimeOfDay(hour: 23, minute: 59),
        startTime: TimeOfDay(hour: 00, minute: 00),
      ),
      Day(
        dayOfWeek: 3,
        endTime: TimeOfDay(hour: 23, minute: 59),
        startTime: TimeOfDay(hour: 00, minute: 00),
      ),
      Day(
        dayOfWeek: 4,
        endTime: TimeOfDay(hour: 23, minute: 59),
        startTime: TimeOfDay(hour: 00, minute: 00),
      ),
      Day(
        dayOfWeek: 5,
        endTime: TimeOfDay(hour: 23, minute: 59),
        startTime: TimeOfDay(hour: 00, minute: 00),
      ),
      Day(
        dayOfWeek: 6,
        endTime: TimeOfDay(hour: 23, minute: 59),
        startTime: TimeOfDay(hour: 00, minute: 00),
      ),
    ],
  ),
];
