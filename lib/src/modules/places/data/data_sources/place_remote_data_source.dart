import 'dart:async';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:hawi_hub_owner/src/core/apis/dio_helper.dart';
import 'package:hawi_hub_owner/src/core/apis/end_points.dart';
import 'package:hawi_hub_owner/src/core/common_widgets/common_widgets.dart';
import 'package:hawi_hub_owner/src/core/utils/constance_manager.dart';
import 'package:hawi_hub_owner/src/modules/main/data/models/app_notification.dart';
import 'package:hawi_hub_owner/src/modules/main/data/services/notification_services.dart';
import 'package:hawi_hub_owner/src/modules/payment/data/services/payment_service.dart';
import 'package:hawi_hub_owner/src/modules/places/data/models/booking.dart';
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

  Future<Either<Exception, Unit>> acceptBookingRequest(
    BookingRequest bookingRequest,
  ) async {
    try {
      List<int> playersIds = [
        bookingRequest.userId,
      ];
      if (bookingRequest.players != null) {
        playersIds.addAll(bookingRequest.players!.map((e) => e.id).toList());
      }
      Future.wait([
        DioHelper.postData(
          query: {"id": bookingRequest.id},
          path: EndPoints.acceptBookingRequest + bookingRequest.id.toString(),
        ),
        _createChat(
        lastTime: bookingRequest.startTime, playerId: bookingRequest.userId),
     PaymentService().transferBalance(
    amount: bookingRequest.price.toDouble(),
    ),
    _sendRequestNotifications(
    playersIds, true, bookingRequest.userId, bookingRequest.placeName)
      ]);
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
      return Left(e as Exception);
    }
  }

  Future<Either<Exception, Unit>> declineBookingRequest(
    BookingRequest bookingRequest,
  ) async {
    try {

      List<int> playersIds = [
        bookingRequest.userId,
      ];
      if (bookingRequest.players != null) {
        playersIds.addAll(bookingRequest.players!.map((e) => e.id).toList());
      }
      Future.wait([   DioHelper.postData(
      query: {"id": bookingRequest.id},
      path: EndPoints.declineBookingRequest + bookingRequest.id.toString(),
    ),

        _sendRequestNotifications(
            playersIds, false, bookingRequest.userId, bookingRequest.placeName)
      ]);
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

  Future<Either<Exception, Unit>> _createChat(
      {required int playerId, required DateTime lastTime}) async {
    try {
      await DioHelper.postData(
        path: EndPoints.addConversation,
        data: {
          "ownerId": ConstantsManager.userId,
          "playerId": playerId,
          "lastTimeToChat": lastTime.toUtc().toIso8601String(),
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
        appFeedBacks = (response.data["reviews"] as List)
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

  Future<Either<Exception, List<Booking>>> getPlaceBookings(
      {required int placeId}) async {
    List<Booking> bookings = [
      Booking(
        startTime: DateTime(2024, 7, 1, 10, 0),
        endTime: DateTime(2024, 7, 1, 12, 0),
      ),
      Booking(
        startTime: DateTime(2024, 7, 2, 14, 0),
        endTime: DateTime(2024, 7, 2, 16, 0),
      ),
      Booking(
        startTime: DateTime(2024, 7, 3, 9, 0),
        endTime: DateTime(2024, 7, 3, 10, 0),
      ),
      Booking(
        startTime: DateTime(2024, 8, 1, 11, 0),
        endTime: DateTime(2024, 8, 1, 13, 0),
      ),
      Booking(
        startTime: DateTime(2024, 8, 5, 15, 0),
        endTime: DateTime(2024, 8, 5, 17, 0),
      ),
    ];

    try {
      // var response = await DioHelper.getData(
      //     path: EndPoints.getPlaceBookings + placeId.toString());
      // if (response.statusCode == 200) {
      //   bookings = (response.data as List)
      //       .map((e) => Booking.fromJson(e))
      //       .toList();
      // }
      startTimer(2.1);
      return Right(bookings);
    } on Exception catch (e) {
      return Left(e);
    }
  }

  Future<Either<Exception, Unit>> addOfflineReservation(
      {required int placeId, required Booking booking}) async {
    try {
      print("request will be sent now");
      await DioHelper.postData(
        path: EndPoints.addOfflineReservation + placeId.toString(),
        data: booking.toJson(),
      );
      return const Right(unit);
    } on Exception catch (e) {
      print("exception : $e");
      return Left(e);
    }
  }

  Future<Either<Exception, Unit>> addPlayerFeedback(
      {required AppFeedBack review, required int ownerId}) async {
    try {
      await DioHelper.postData(
        data: review.toJson(userType: "player"),
        path: EndPoints.addPlayerFeedback + ownerId.toString(),
      );
      return const Right(unit);
    } on Exception catch (e) {
      return Left(e);
    }
  }

  Future _sendRequestNotifications(
      List<int> ids, bool isAccepted, int requestId, String placeName) async {
    if (isAccepted) {

      Future.wait(
        ids.map((id) => NotificationServices().sendNotification(AppNotification(
            title: "تم قبول طلبك",
            body: ": $placeNameتم قبول طلب حجز الملعب ",
            id: id,
            receiverId: id)))
      );
    } else {
      Future.wait(
        ids.map((id) => NotificationServices().sendNotification(AppNotification(
            title: "تم رفض طلبك",
            body: ": $placeNameتم رفض طلب حجز الملعب ",
            id: id,
            receiverId: id)))
      );
    }
  }
}

Future<bool> startTimer(double seconds) async {
  int secondsInt = seconds.truncate();
  int milliseconds = (seconds - secondsInt).toInt() * 1000;
  print("Timer started");
  await Future.delayed(
      Duration(seconds: secondsInt, milliseconds: milliseconds));
  print("Timer ended");
  return true;
}
