import 'dart:async';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:hawi_hub_owner/src/core/apis/dio_helper.dart';
import 'package:hawi_hub_owner/src/core/apis/end_points.dart';
import 'package:hawi_hub_owner/src/core/common_widgets/common_widgets.dart';
import 'package:hawi_hub_owner/src/core/utils/constance_manager.dart';
import 'package:hawi_hub_owner/src/modules/places/data/models/booking_request.dart';
import 'package:hawi_hub_owner/src/modules/places/data/models/feedback.dart';
import 'package:hawi_hub_owner/src/modules/places/data/models/place.dart';
import 'package:hawi_hub_owner/src/modules/places/data/models/place_creation_form.dart';
import 'package:hawi_hub_owner/src/modules/places/data/models/place_edit_form.dart';

class PlaceRemoteDataSource {
  Future<Either<Exception, List<Place>>> getPlaces() async {
    try {
      //print("getPlaces called");
      List<Place> places = [];
      var response = await DioHelper.getData(
          path:
              "${EndPoints.getPlaces}${ConstantsManager.userId}" /*TODO : userId */,
          query: {"id": ConstantsManager.userId});

      print(response.data);
      //print(response);
      if (response.statusCode == 200) {
        places = (response.data as List).map((e) => Place.fromJson(e)).toList();

        //print(places.map((e) => e.workingHours![0]));
      }

      return Right(places);

      // await startTimer(2.1);
      //

      // return Right(dummyPlaces);
    } on FormatException {
      //print(e);
      return const Right([]);
    } on Exception catch (e) {
      //print(e);
      return Left(e);
    }
  }

  Future<Either<Exception, Unit>> createPlace(
      PlaceCreationForm placeCreationForm) async {
    try {
      debugPrint("creating place");
      var res = await DioHelper.postData(
        path: EndPoints.createPlace,
        data: placeCreationForm.toJson(),
      );
      print(res);
      defaultToast(msg: "Place Created Successfully");
      return const Right(unit);
    } on Exception catch (e) {
      DioException dioException = e as DioException;
      print(dioException.response);
      return Left(e);
    }
  }

  Future<Either<Exception, Unit>> updatePlace(int placeId,
      {required PlaceEditForm newPlace}) async {
    try {
      await DioHelper.putData(
        query: {"id": placeId},
        path: EndPoints.updatePlace + placeId.toString(),
        data: newPlace.toJson(),
      );

      return const Right(unit);
    } on DioException catch (e) {
      DioException dioException = e;
      print(
          "......................................................................الايرور هنا ....................................................");
      print(dioException.error.toString() +
          dioException.response.toString() +
          dioException.message.toString() +
          dioException.requestOptions.toString());
      return Left(e);
    } on Exception catch (e) {
      DioException dioException = e as DioException;
      print(
          "......................................................................الايرور هنا ....................................................");
      print(dioException.error.toString() +
          dioException.response.toString() +
          dioException.message.toString() +
          dioException.requestOptions.toString());
      return Left(e);
    }
  }

  Future<Either<Exception, Unit>> deletePlace(int placeId) async {
    try {
      await DioHelper.deleteData(
          path: EndPoints.deletePlace + placeId.toString(),
          query: {
            "id": placeId,
          }).then((value) {
        //print(value.statusCode.toString() + value.data.toString());
      });
      return const Right(unit);
    } on DioException catch (e) {
      return Left(e);
    } on Exception catch (e) {
      return Left(e);
    }
  }

  Future<Either<Exception, List<BookingRequest>>> getBookingRequests() async {
    try {
      List<BookingRequest> bookingRequests = [];
      var response = await DioHelper.getData(
          path: "${EndPoints.getBookingRequest}${ConstantsManager.userId}",
          query: {"id": ConstantsManager.userId});
      if (response.statusCode == 200) {
        List data = response.data as List;
        data.removeWhere((element) => element["approvalStatus"] != 0);
        bookingRequests =
            (data).map((e) => BookingRequest.fromJson(e)).toList();
      }
      return Right(bookingRequests);
    } on DioException catch (e) {
      return Left(e);
    } on Exception catch (e) {
      return Left(e);
    }
  }

  Future<Either<Exception, Unit>> acceptBookingRequest(int requestId) async {
    try {
      await DioHelper.postData(
        query: {"id": requestId},
        path: EndPoints.acceptBookingRequest + requestId.toString(),
      );
      await _createChat();
      return const Right(unit);
    } on DioException catch (e) {
      DioException dioException = e;
      print(
          "......................................................................الايرور هنا ....................................................");
      print(dioException.error.toString() +
          dioException.response.toString() +
          dioException.message.toString() +
          dioException.requestOptions.toString());
      return Left(e);
    } catch (e) {
      return Left(e as Exception);
    }
  }

  Future<Either<Exception, Unit>> declineBookingRequest(int requestId) async {
    try {
      await DioHelper.postData(
        query: {"id": requestId},
        path: EndPoints.declineBookingRequest + requestId.toString(),
      );
      return const Right(unit);
    } on DioException catch (e) {
      DioException dioException = e;
      print(
          "......................................................................الايرور هنا ....................................................");
      print(dioException.error.toString() +
          dioException.response.toString() +
          dioException.message.toString() +
          dioException.requestOptions.toString());
      return Left(e);
    } on Exception catch (e) {
      return Left(e);
    }
  }

  Future<Either<Exception, Unit>> createBooking(
      {required int placeId,
      required DateTime bookingStartTime,
      required DateTime bookingEndTime}) async {
    try {
      await DioHelper.postData(
        path: EndPoints.createBooking + placeId.toString(),
        query: {"id": placeId},
        data: {
          "reservationStartTime": bookingStartTime.toString(),
          "reservationEndTime": bookingEndTime.toString()
        },
      );
      return const Right(unit);
    } on Exception catch (e) {
      //print(e);
      return Left(e);
    }
  }

  Future<Either<Exception, Unit>> _createChat() async {
    try {
      await DioHelper.postData(
        path: EndPoints.addConversation,
        data: {
          "ownerId": ConstantsManager.userId,
          "playerId": 1,
          "lastTimeToChat": "2025-05-27T16:37:05.049Z"
        },
      );
      return const Right(unit);
    } on Exception catch (e) {
      return Left(e);
    }
  }

  Future<Either<Exception, List<AppFeedBack>>> getPlaceFeedbacks(
      int placeId) async {
    try {
      List<AppFeedBack> appFeedBacks = [];
      var response = await DioHelper.getData(
          path: EndPoints.getPlaceFeedbacks + placeId.toString());
      if (response.statusCode == 200) {
        appFeedBacks = (response.data as List)
            .map((e) => AppFeedBack.fromJson(e))
            .toList();
      }
      return Right(appFeedBacks);
    } on Exception catch (e) {
      return Left(e);
    }
  }

  Future<Either<Exception, String>> uploadProfFile({
    required File file,
  }) async {
    try {
      FormData formData = FormData.fromMap({
        "ProofOfOwnershipFile": MultipartFile.fromFileSync(file.path),
      });
      var response = await DioHelper.postFormData(
          EndPoints.uploadProofOfOwnership, formData);
      print(response.data);
      return Right(response.data["proofOfOwnershipUrl"]);
    } on Exception catch (e) {
      return Left(e);
    }
  }

  Future<Either<Exception, List<String>>> uploadPlaceImages({
    required List<File> files,
  }) async {
    try {
      List<String> images = [];
      var response = await DioHelper.postFormData(
          EndPoints.uploadPlaceImages,
          FormData.fromMap({
            "images":
                files.map((e) => MultipartFile.fromFileSync(e.path)).toList(),
          }));

      if (response.statusCode == 200) {
        images = (response.data["imegesUrl"] as List)
            .map((e) => e.toString())
            .toList();
      }
      return Right(images);
    } on Exception catch (e) {
      return Left(e);
    }
  }
}

Future<bool> startTimer(double seconds) async {
  int secondsInt = seconds.truncate();
  int milliseconds = (seconds - secondsInt).toInt() * 1000;
  await Future.delayed(
      Duration(seconds: secondsInt, milliseconds: milliseconds));
  return true;
}
