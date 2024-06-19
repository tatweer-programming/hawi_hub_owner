import 'dart:convert';

import 'package:hawi_hub_owner/src/core/utils/constance_manager.dart';

class AppNotification {
   final int id;
  final String title;
  final int receiverId;
  final String body;
  final String? image;
  final String? link;
  final DateTime? dateTime;
  AppNotification(
      {required this.title,
      required this.body,
      required this.id,
      this.image,
      this.link,
      this.dateTime,
      required this.receiverId});

  factory AppNotification.fromJson(Map<String, dynamic> json) {
    return AppNotification(
      id: json['notificationId'],
      receiverId: ConstantsManager.userId!,
      dateTime: DateTime.parse(json['createdAt']),
      title: json['notificationTitle'],
      body: json['notificationMessage'],
      image: json['notificationImageUrl'],
      link: json['notificationImageUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "message": body,
      "imageUrl": image,
    };
  }

  String jsonBody() {
    return jsonEncode({
      "to": "/topics/player:$receiverId",
      "notification": {
        "body": body,
        "click_action": "FLUTTER_NOTIFICATION_CLICK",
        "title": title,
        "image": image,
      }
    });
  }
}
