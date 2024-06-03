import 'package:dartz/dartz.dart';

import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:hawi_hub_owner/src/core/apis/dio_helper.dart';
import 'package:hawi_hub_owner/src/core/apis/end_points.dart';
import 'package:hawi_hub_owner/src/modules/main/data/models/app_notification.dart';
import 'package:web_socket_channel/io.dart';

import '../../../../core/utils/constance_manager.dart';
import 'package:http/http.dart' as http;

class NotificationServices {
  static IOWebSocketChannel? channel;
  static FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  static Future<void> init() async {
    await _firebaseMessaging.requestPermission();
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
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
        List<AppNotification> notifications =
            (response.data as List).map((e) => AppNotification.fromJson(e)).toList();
        return Right(notifications);
      }
      return const Right([]);
    } catch (e) {
      return Left(e as Exception);
    }
  }

  void sendNotification(AppNotification notification) async {
    await http.post(Uri.parse(ConstantsManager.baseUrlNotification),
        body: notification.jsonBody(),
        headers: {
          "Authorization": "key=${ConstantsManager.firebaseMessagingAPI}",
          "Content-Type": "application/json"
        });
    await _saveNotification();
  }

  Future<bool> markAsRead(int id) async {
    try {
      var response = await DioHelper.postData(path: EndPoints.markAsRead + id.toString());
      if (response.statusCode == 200) {
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
  ) async {}
  Future<Either<Exception, Unit>> _saveNotification() async {
    throw UnimplementedError();
  }

  Future subscribeToTopic() async {
    await _firebaseMessaging.subscribeToTopic(ConstantsManager.userId.toString());
  }
}
