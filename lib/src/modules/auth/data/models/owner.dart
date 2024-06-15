import 'dart:io';

import 'package:hawi_hub_owner/src/core/apis/api.dart';
import 'package:hawi_hub_owner/src/modules/places/data/models/feedback.dart';

class Owner {
  final int id;
  final int approvalStatus;
  final String userName;
  final double? rate;
  final String email;
  final String? supplierCode;
  final String? profilePictureUrl;
  final double myWallet;
  final List<AppFeedBack> feedbacks;
  File? profilePictureFile;
  String? nationalIdPicture;

  Owner({
    required this.id,
    required this.userName,
    required this.email,
    required this.approvalStatus,
    required this.profilePictureUrl,
    this.profilePictureFile,
    this.nationalIdPicture,
    this.supplierCode,
    required this.myWallet,
    required this.feedbacks,
    required this.rate,
  });

  factory Owner.fromJson(Map<String, dynamic> json) {
    List<AppFeedBack> feedbacks = List.from(json['reviews'] ?? [])
        .map((feedback) => AppFeedBack.fromJson(feedback))
        .toList();
    return Owner(
      profilePictureUrl: json['profilePictureUrl'],
      id: json['id'],
      nationalIdPicture: json['proofOfIdentityUrl'] != null
          ? ApiManager.handleImageUrl(json['proofOfIdentityUrl'])
          : null,
      userName: json['userName'],
      // supplierCode: json['supplierCode'],
      email: json['email'],
      approvalStatus: json['approvalStatus'],
      myWallet: json['wallet'].toDouble(),
      feedbacks: feedbacks,
      rate: _calculateAverage(feedbacks),
    );
  }

  static double _calculateAverage(List<AppFeedBack>? feedbacks) {
    List<double> numbers =
        List.from(feedbacks!.map((feedBack) => feedBack.rating));
    if (numbers.isEmpty) {
      return 0.0;
    }
    double sum = 0.0;
    for (double number in numbers) {
      sum += number;
    }

    return sum / numbers.length;
  }
}
