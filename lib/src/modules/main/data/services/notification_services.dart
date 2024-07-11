import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:hawi_hub_owner/src/core/apis/dio_helper.dart';
import 'package:hawi_hub_owner/src/core/apis/end_points.dart';
import 'package:hawi_hub_owner/src/core/common_widgets/common_widgets.dart';
import 'package:hawi_hub_owner/src/modules/main/data/models/app_notification.dart';
import 'package:http/http.dart' as http;

import '../../../../core/utils/constance_manager.dart';

class NotificationServices {
  static final FirebaseMessaging _firebaseMessaging =
      FirebaseMessaging.instance;

  static Future<void> init() async {
    await _firebaseMessaging.requestPermission();
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print(message.data.toString());
      defaultToast(msg: message.notification?.title ?? "");
      print(
        message.notification?.title,
      );
    });
  }

  Future<Either<Exception, List<AppNotification>>> getNotifications() async {
    if (ConstantsManager.userId == null) {
      return const Right([]);
    }
    try {
      var response = await DioHelper.getData(
        path: EndPoints.getNotifications + ConstantsManager.userId.toString(),
        query: {"ownerId": ConstantsManager.userId, "readed": false},
      );
      if (response.statusCode == 200) {
        List<AppNotification> notifications = (response.data as List)
            .map((e) => AppNotification.fromJson(e))
            .toList();
        return Right(notifications);
      }
      return const Right([]);
    } on Exception catch (e) {
      return Left(e);
    }
  }

  Future sendNotification(AppNotification notification) async {
    await http.post(Uri.parse(ConstantsManager.baseUrlNotification),
        body: notification.jsonBody(),
        headers: {
          "Authorization": "key=${ConstantsManager.firebaseMessagingAPI}",
          "Content-Type": "application/json"
        }).then((value) {
      print("Notification sent successfully ${value.body} \n ${value.headers}");
    });
    await _saveNotification(notification);
  }

  Future<bool> markAsRead(int id) async {
    try {
      var response =
          await DioHelper.postData(path: EndPoints.markAsRead + id.toString());
      if (response.statusCode == 200) {
        print("Marked as read successfully");
        return true;
      }
      return false;
    } catch (e) {
      print("Error in marking notification as read: $e");
      return false;
    }
  }

  static Future<void> _firebaseMessagingBackgroundHandler(
    RemoteMessage message,
  ) async {
    print(message.data.toString());
    print(message.notification?.title);
  }

  Future<Either<Exception, Unit>> _saveNotification(
      AppNotification notification) async {
    try {
      await DioHelper.postData(
          path: EndPoints.saveNotificationToPlayer +
              notification.receiverId.toString(),
          data: notification.toJson(),
          query: {"playerId": notification.receiverId});
      print("Notification saved successfully");

      return const Right(unit);
    } on DioException catch (e) {
      print(
          "Error in saving notification: ${e.response?.data} ${e.message} ${e.requestOptions} ${e.response} ${e.type} ${e.error} ${e.stackTrace}");
      return Left(e);
    } on Exception catch (e) {
      print("Error in saving notification: $e");
      return Left(e);
    }
  }

  Future subscribeToTopic() async {
    print(ConstantsManager.userId);
    await _firebaseMessaging
        .subscribeToTopic("owner_${ConstantsManager.userId}");
  }
}
