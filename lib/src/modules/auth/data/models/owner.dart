import 'dart:io';

import 'package:hawi_hub_owner/src/modules/places/data/models/feedback.dart';

class Owner {
  final int id;
  final String userName;
  final double? rate;
  final String email;
  final String profilePictureUrl;
  final double myWallet;
  final List<FeedBack> feedbacks;
  File? profilePictureFile;
  File? ownershipProofFile;

  Owner({
    required this.id,
    required this.userName,
    required this.email,
    required this.profilePictureUrl,
    this.profilePictureFile,
    this.ownershipProofFile,
    required this.myWallet,
    required this.feedbacks,
    required this.rate,
  });

  factory Owner.fromJson(Map<String, dynamic> json) {
    return Owner(
      profilePictureUrl: json['profile_image'],
      id: json['id'],
      userName: json['user_name'],
      email: json['email'],
      myWallet: json['my_wallet'].toDouble(),
      rate: json['rate'] != null ? json['rate'].toDouble() : 0.0,
      feedbacks: [],
    );
  }
}
