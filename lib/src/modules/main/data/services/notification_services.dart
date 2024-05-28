import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hawi_hub_owner/src/core/apis/api.dart';
import 'package:hawi_hub_owner/src/core/apis/dio_helper.dart';
import 'package:hawi_hub_owner/src/core/apis/end_points.dart';
import 'package:hawi_hub_owner/src/modules/chat/data/models/connection.dart';
import 'package:hawi_hub_owner/src/modules/main/data/models/app_notification.dart';
import 'package:hawi_hub_owner/src/modules/places/data/data_sources/place_remote_data_source.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:signalr_core/signalr_core.dart' as signalr;

import '../../../../core/utils/constance_manager.dart';

class NotificationServices {
  // late signalr.HubConnection hubConnection;
  // late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  static IOWebSocketChannel? channel;
  static Future<void> init() async {
    if (ConstantsManager.userId == null) {
      return;
    }
    // add connection id to db
    // add connection token to db
    // add notification listener

    Connection hubConnection = await _getHubConnection();
    print(hubConnection.id + " _ " + ConstantsManager.userId.toString());
    await _saveConnectionId(hubConnection.id);
    await _saveConnectionToken(hubConnection.token);
    _notifyListeners();
    // hubConnection = await _getHubConnection();
    // flutterLocalNotificationsPlugin = await _getFlutterLocalNotificationsPlugin();
    // _notifyListeners();
  }

  static Future<Connection> _getHubConnection() async {
    Connection? connection;
    await DioHelper.postData(
      path: EndPoints.getConnection,
    ).then((value) {
      connection = Connection.fromJson(value.data);
    });
    return connection!;
  }

  static Future<bool> _saveConnectionId(String connectionId) async {
    try {
      var response = await DioHelper.postData(
          path: EndPoints.saveConnectionId + ConstantsManager.userId.toString(),
          data: {"ownerConnectionId": connectionId},
          query: {"ownerId": ConstantsManager.userId});
      if (response.statusCode == 200) {
        print("connection id saved");
        return true;
      }
      return false;
      return true;
    } on DioException catch (e) {
      print("error in saving connection id>>>>>>>>>>>>>>>>>>>>>>>>>>>>> "
          "\n ${e.message} , \n ${e.error} , \n ${e.stackTrace} , \n ${e.type}");
      return false;
    } on Exception catch (e) {
      print(e);
      return false;
    }
  }

  static Future<bool> _saveConnectionToken(String connectionToken) async {
    try {
      channel = IOWebSocketChannel.connect(
        ApiManager.webSocket + connectionToken,
        headers: {"Authorization": ApiManager.authToken},
      );
      const String messageWithTrailingChars = '{"protocol":"json","version":1}';
      channel!.sink.add(messageWithTrailingChars);
      channel!.stream.listen((event) {
        print("message    $event");
      });
      print("connection token saved");
      return true;
    } on Exception catch (e) {
      return false;
    }
  }

  static _notifyListeners() {}

  Future<Either<Exception, List<AppNotification>>> getNotifications() async {
    if (ConstantsManager.userId == null) {
      return const Right([]);
    }
    try {
      List<AppNotification> notifications = [];
      var response = await DioHelper.getData(
          path: EndPoints.getNotifications + ConstantsManager.userId.toString(),
          query: {"ownerId": ConstantsManager.userId, "readed": false});
      if (response.statusCode == 200) {
        notifications = (response.data as List).map((e) => AppNotification.fromJson(e)).toList();
      }
      return Right(notifications);
    } on Exception catch (e) {
      return Left(e);
    }
  }

  void sendNotification(AppNotification notification) async {
    channel!.sink.add(notification.toString());
  }

  Future<bool> markAsRead(int id) async {
    try {
      var response = await DioHelper.postData(path: EndPoints.markAsRead + id.toString());
      if (response.statusCode == 200) {
        return true;
      }
      // markAsRead(id);
      return false;
    } on Exception catch (e) {
      return false;
    }
  }
}

/*


   void initializeSignalR() async {
    hubConnection = signalr.HubConnectionBuilder().withUrl(ApiManager.webSocket).build();
    await hubConnection.start();
    hubConnection.on('ReceiveNotification', _handleNotification);
  }

  void initializeNotifications() async {
    var initializationSettingsAndroid = const AndroidInitializationSettings('app_icon');
    var initializationSettings = InitializationSettings(android: initializationSettingsAndroid);
    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
    );
  }

  void _handleNotification(List<dynamic>? args) async {
    var notificationJson = args?[0] as Map<String, dynamic>;
    var notification = AppNotification.fromJson(notificationJson);
    await _showNotification(notification);
  }

  Future<void> _showNotification(AppNotification notification) async {
    var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
      'notification_channel_id',
      'Notifications',
      importance: Importance.max,
      priority: Priority.high,
    );
    var platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
      0,
      notification.title,
      notification.body,
      platformChannelSpecifics,
      payload: notification.link,
    );
  }

  Future<void> _onSelectNotification(String? payload) async {
    // Handle notification click here
  }
 */
