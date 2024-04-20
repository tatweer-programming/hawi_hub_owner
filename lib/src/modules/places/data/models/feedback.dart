import 'package:equatable/equatable.dart';

class FeedBack extends Equatable {
  final int? id;
  final int userId;
  final String? comment;
  final String userName;
  final String? userImageUrl;
  final double rating;

  const FeedBack({
    this.id,
    required this.userId,
    this.comment,
    required this.userName,
    this.userImageUrl,
    required this.rating,
  });
  factory FeedBack.fromJson(Map<String, dynamic> json) {
    return FeedBack(
      id: json['id'],
      userId: json['user_id'],
      comment: json['comment'],
      userName: json['user_name'],
      userImageUrl: json['user_image_url'],
      rating: json['rating'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'comment': comment,
      'rating': rating,
    };
  }

  factory FeedBack.create({
    String? comment,
    required double rating,
  }) {
    return FeedBack(
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
