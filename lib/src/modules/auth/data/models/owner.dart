import 'dart:io';

import 'package:hawi_hub_owner/src/modules/places/data/models/feedback.dart';

class Owner {
  final int id;
  final int emailConfirmed;
  final String userName;
  final double? rate;
  final String email;
  final String profilePictureUrl;
  final double myWallet;
  final List<AppFeedBack> feedbacks;
  File? profilePictureFile;
  File? nationalIdPicture;

  Owner({
    required this.id,
    required this.userName,
    required this.email,
    required this.emailConfirmed,
    required this.profilePictureUrl,
    this.profilePictureFile,
    this.nationalIdPicture,
    required this.myWallet,
    required this.feedbacks,
    required this.rate,
  });

  factory Owner.fromJson(Map<String, dynamic> json) {
    return Owner(
      profilePictureUrl: json['profilePicture'],
      id: json['ownerId'],
      nationalIdPicture: json['nationalIdPicture'],
      userName: json['userName'],
      email: json['email'],
      emailConfirmed: json['emailConfirmed'],
      myWallet: json['wallet'].toDouble(),
      rate: json['rate'] != null ? json['rate'].toDouble() : 0.0,
      feedbacks:
          List.from(json['reviews']).map((feedBack) => AppFeedBack.fromJson(feedBack)).toList(),
    );
  }
}
