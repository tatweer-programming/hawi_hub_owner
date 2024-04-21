import 'dart:async';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:hawi_hub_owner/src/core/apis/dio_helper.dart';
import 'package:hawi_hub_owner/src/core/apis/end_points.dart';
import 'package:hawi_hub_owner/src/core/utils/constance_manager.dart';
import 'package:hawi_hub_owner/src/modules/places/data/data_sources/dummy_data.dart';
import 'package:hawi_hub_owner/src/modules/places/data/models/booking_request.dart';
import 'package:hawi_hub_owner/src/modules/places/data/models/place.dart';
import 'package:hawi_hub_owner/src/modules/places/data/models/place_creation_form.dart';

class PlaceRemoteDataSource {
  Future<Either<Exception, List<Place>>> getPlaces() async {
    try {
      // List<Place> places = [];
      // var response = await DioHelper.getData(
      //     path: EndPoints.getPlaces, query: {"token": ConstantsManager.userToken});
      // if (response.statusCode == 200) {
      //   places = (response.data as List).map((e) => Place.fromJson(e)).toList();
      // }
      // return Right(places);

      await startTimer(2.1);

      return Right(dummyPlaces);
    } on Exception catch (e) {
      return Left(e);
    }
  }

  Future<Either<Exception, Unit>> createPlace(PlaceCreationForm placeCreationForm) async {
    try {
      var response = await DioHelper.postData(
          path: EndPoints.createPlace,
          data: placeCreationForm.toJson(),
          query: {"token": ConstantsManager.userToken});
      if (response.statusCode == 200) {
        return const Right(unit);
      }
      return Left(Exception(response.data['message']));
    } on Exception catch (e) {
      return Left(e);
    }
  }

  Future<Either<Exception, List<String>>> uploadImages(List<File> images) async {
    try {
      var response = await DioHelper.postData(
          path: EndPoints.uploadImages, data: images, query: {"token": ConstantsManager.userToken});
      if (response.statusCode == 200) {
        return Right((response.data as List).map((e) => e.toString()).toList());
      }
      return Left(Exception(response.data['message']));
    } on Exception catch (e) {
      return Left(e);
    }
  }

  Future<Either<Exception, Unit>> updatePlace(int placeId,
      {required PlaceCreationForm newPlace}) async {
    try {
      var response = await DioHelper.putData(
          path: EndPoints.updatePlace,
          data: newPlace.toJson(),
          query: {"token": ConstantsManager.userToken});
      if (response.statusCode == 200) {
        return const Right(unit);
      }
      return Left(Exception(response.data['message']));
    } on Exception catch (e) {
      return Left(e);
    }
  }

  Future<Either<Exception, Unit>> deletePlace(int placeId) async {
    try {
      var response = await DioHelper.deleteData(
          path: EndPoints.deletePlace, query: {"token": ConstantsManager.userToken});
      if (response.statusCode == 200) {
        return const Right(unit);
      }
      return Left(Exception(response.data['message']));
    } on Exception catch (e) {
      return Left(e);
    }
  }

  Future<Either<Exception, List<BookingRequest>>> getBookingRequests() async {
    try {
      List<BookingRequest> bookingRequests = [];
      var response = await DioHelper.getData(path: EndPoints.getBookingRequest);
      if (response.statusCode == 200) {
        bookingRequests = (response.data as List).map((e) => BookingRequest.fromJson(e)).toList();
      }
      return Right(bookingRequests);
    } on Exception catch (e) {
      return Left(e);
    }
  }

  Future<Either<Exception, Unit>> acceptBookingRequest(int requestId) async {
    try {
      var response = await DioHelper.postData(
          path: EndPoints.acceptBookingRequest, data: {"request_id": requestId});
      if (response.statusCode == 200) {
        return const Right(unit);
      }
      return Left(Exception(response.data['message']));
    } on Exception catch (e) {
      return Left(e);
    }
  }

  Future<Either<Exception, Unit>> declineBookingRequest(int requestId) async {
    try {
      var response = await DioHelper.postData(
          path: EndPoints.declineBookingRequest, data: {"request_id": requestId});
      if (response.statusCode == 200) {
        return const Right(unit);
      }
      return Left(Exception(response.data['message']));
    } on Exception catch (e) {
      return Left(e);
    }
  }
}

Future<bool> startTimer(double seconds) async {
  int secondsInt = seconds.truncate();
  int milliseconds = (seconds - secondsInt).toInt() * 1000;

  await Future.delayed(Duration(seconds: secondsInt, milliseconds: milliseconds));
  return true;
}
