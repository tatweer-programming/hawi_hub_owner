import 'dart:io';

import 'package:hawi_hub_owner/src/core/apis/api.dart';
import 'package:hawi_hub_owner/src/modules/places/data/models/feedback.dart';

class Owner {
  final int id;
  final int approvalStatus;
  final String userName;
  final double rate;
  final String email;
  final String? supplierCode;
  final String? profilePictureUrl;
  final double myWallet;
  final List<AppFeedBack> feedbacks;
  final List<int> playerReservation;
  File? profilePictureFile;
  String? nationalIdPicture;

  Owner({
    required this.id,
    required this.userName,
    required this.email,
    required this.approvalStatus,
    required this.profilePictureUrl,
    required this.playerReservation,
    this.profilePictureFile,
    this.nationalIdPicture,
    this.supplierCode,
    required this.myWallet,
    required this.feedbacks,
    required this.rate,
  });

  factory Owner.fromJson(Map<String, dynamic> json) {
    return Owner(
      profilePictureUrl: json['profilePictureUrl'],
      id: json['id'],
      nationalIdPicture: json['proofOfIdentityUrl'] != null
          ? ApiManager.handleImageUrl(json['proofOfIdentityUrl'])
          : null,
      userName: json['userName'],
      supplierCode: json['supplierCode'],
      email: json['email'],
      approvalStatus: json['approvalStatus'],
      myWallet: json['wallet'].toDouble(),
      feedbacks: [],
      rate: json["rate"].toDouble(),
      playerReservation: List.from(json['playerReservation'] ?? []),
    );
  }
}
