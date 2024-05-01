import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:hawi_hub_owner/src/core/apis/dio_helper.dart';
import 'package:hawi_hub_owner/src/core/apis/end_points.dart';
import 'package:hawi_hub_owner/src/modules/places/data/data_sources/dummy_data.dart';
import 'package:hawi_hub_owner/src/modules/places/data/models/booking_request.dart';
import 'package:hawi_hub_owner/src/modules/places/data/models/place.dart';
import 'package:hawi_hub_owner/src/modules/places/data/models/place_creation_form.dart';
import 'package:hawi_hub_owner/src/modules/places/data/models/place_edit_form.dart';

class PlaceRemoteDataSource {
  Future<Either<Exception, List<Place>>> getPlaces() async {
    try {
      List<Place> places = [];
      var response = await DioHelper.getData(path: EndPoints.getPlaces, query: {
        "id": 1 //ConstantsManager.userId
      });
      print(response.data);
      if (response.statusCode == 200) {
        places = (response.data as List).map((e) => Place.fromJson(e)).toList();

        print(places);
      }
      return Right(places);

      // await startTimer(2.1);
      //

      // return Right(dummyPlaces);
    } on Exception catch (e) {
      print(e);
      return Left(e);
    }
  }

  Future<Either<Exception, Unit>> createPlace(PlaceCreationForm placeCreationForm) async {
    try {
      // return const Right(unit);
      FormData formData = placeCreationForm.toFormData();
      var response = await DioHelper.postFormData(
        EndPoints.createPlace,
        formData,
      );
      if (response.statusCode == 200) {
        print("added");
        return const Right(unit);
      }
      return Left(Exception(response.data['errors']));
    } on Exception catch (e) {
      print(e);
      return Left(e);
    }
  }

  Future<Either<Exception, Unit>> updatePlace(int placeId,
      {required PlaceEditForm newPlace}) async {
    try {
      var response = await DioHelper.putDataFormData(
        query: {"id": placeId},
        path: EndPoints.updatePlace,
        data: newPlace.toFormData(),
      );
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
      var response =
          await DioHelper.deleteData(path: EndPoints.deletePlace + placeId.toString(), query: {
        "id": placeId,
      });
      if (response.statusCode == 200) {
        return const Right(unit);
      }
      return Left(Exception(response.data['errors']));
    } on Exception catch (e) {
      return Left(e);
    }
  }

  Future<Either<Exception, List<BookingRequest>>> getBookingRequests() async {
    try {
      List<BookingRequest> bookingRequests = [];
      // var response = await DioHelper.getData(path: EndPoints.getBookingRequest);
      // if (response.statusCode == 200) {
      //   bookingRequests = (response.data as List).map((e) => BookingRequest.fromJson(e)).toList();
      // }
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
