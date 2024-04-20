import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:hawi_hub_owner/src/modules/places/data/models/booking_request.dart';
import 'package:hawi_hub_owner/src/modules/places/data/models/place.dart';
import 'package:hawi_hub_owner/src/modules/places/data/models/place_creation_form.dart';

class PlaceRemoteDataSource {
  Future<Either<Exception, List<Place>>> getPlaces() {
    throw UnimplementedError();
  }

  Future<Either<Exception, Unit>> createPlace(PlaceCreationForm placeCreationForm) {
    throw UnimplementedError();
  }

  Future<Either<Exception, List<String>>> uploadImages(List<File> images) {
    throw UnimplementedError();
  }

  Future<Either<Exception, Unit>> updatePlace(int placeId, {required PlaceCreationForm newPlace}) {
    throw UnimplementedError();
  }

  Future<Either<Exception, Unit>> deletePlace(int placeId) {
    throw UnimplementedError();
  }

  Future<Either<Exception, List<BookingRequest>>> getBookingRequests() {
    throw UnimplementedError();
  }

  Future<Either<Exception, Unit>> acceptBookingRequest(int requestId) {
    throw UnimplementedError();
  }

  Future<Either<Exception, Unit>> declineBookingRequest(int requestId) {
    throw UnimplementedError();
  }
}
