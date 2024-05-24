import 'package:equatable/equatable.dart';
import 'package:hawi_hub_owner/src/core/utils/images_manager.dart';

class BookingRequest extends Equatable {
// use data
  final int userId;
  final String userName;
  final String userImage;

  // request data
  int? id;
  final DateTime startTime;
  final DateTime endTime;
  final double price;

  // place data
  final String placeName;
  final String address;
  final int placeId;
  // final List<Player> players = [];
  BookingRequest({
    required this.userId,
    required this.userName,
    required this.userImage,
    this.id,
    required this.startTime,
    required this.endTime,
    required this.price,
    required this.placeName,
    required this.address,
    required this.placeId,
  });
  factory BookingRequest.fromJson(Map<String, dynamic> json) {
    return BookingRequest(
      userId: json['playerId'],
      userName: json['player']['userName'],
      userImage: json['player']['profilePictureUrl'] ?? ImagesManager.defaultProfile,
      id: json['playerId'],
      startTime: DateTime.parse(json["reservationStartTime"]),
      endTime: DateTime.parse(json['reservationEndTime']),
      price: json['reservationPrice'].toDouble(),
      placeName: "",
      address: "",
      placeId: json['stadiumId'],
    );
  }
  @override
  List<Object?> get props => [];
}
