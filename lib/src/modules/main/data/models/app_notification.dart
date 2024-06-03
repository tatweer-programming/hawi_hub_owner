import 'dart:convert';

import 'package:hawi_hub_owner/src/core/utils/constance_manager.dart';

class AppNotification {
  final String title;
  final int receiverId;
  final String body;
  final String? image;
  final String? link;
  final DateTime? dateTime;
  AppNotification(
      {required this.title,
      required this.body,
      this.image,
      this.link,
      this.dateTime,
      required this.receiverId});

  factory AppNotification.fromJson(Map<String, dynamic> json) {
    return AppNotification(
      receiverId: ConstantsManager.userId!,
      dateTime: DateTime.parse(json['date_time']),
      title: json['title'],
      body: json['body'],
      image: json['image'],
      link: json['link'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'body': body,
      'image': image,
      'link': link,
      'date_time': DateTime.now().toIso8601String(),
    };
  }

  String jsonBody() {
    return jsonEncode({
      "to": "/topics/$receiverId",
      "notification": {
        "body": body,
        "click_action": "FLUTTER_NOTIFICATION_CLICK",
        "title": title,
        "image": image,
      }
    });
  }
}
