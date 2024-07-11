import 'package:equatable/equatable.dart';
import 'package:hawi_hub_owner/src/core/utils/images_manager.dart';

class AppFeedBack extends Equatable {
  final int? id;
  final int userId;
  final String? comment;
  final String userName;
  final String? userImageUrl;
  final double rating;

  const AppFeedBack({
    this.id,
    required this.userId,
    this.comment,
    required this.userName,
    this.userImageUrl,
    required this.rating,
  });
  factory AppFeedBack.fromJson(
      Map<String, dynamic> json,
      ) {
    return AppFeedBack(
      id: json['id'],
      userId: json['reviewerId'],
      comment: json['comment'],
      userName: json['reviewerName'],
      userImageUrl:
      json['reviewerProfilePictureUrl'] ?? ImagesManager.defaultProfile,
      rating: json['rate'],
    );
  }

  Map<String, dynamic> toJson({required String userType}) {
    return {
      '${userType}Id': userId,
      'comment': comment,
      'rating': rating,
    };
  }

  factory AppFeedBack.create({
    String? comment,
    required double rating,
  }) {
    return AppFeedBack(
      comment: comment,
      rating: rating,
      userId: 1,
      userName: "",
    );
  }
  @override
  List<Object?> get props => [
        id,
      ];
}
