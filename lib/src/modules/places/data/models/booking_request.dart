import 'package:equatable/equatable.dart';

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
      userId: json['user_id'],
      userName: json['user_name'],
      userImage: json['user_image'],
      id: json['id'],
      startTime: DateTime.parse(json['start_time']),
      endTime: DateTime.parse(json['end_time']),
      price: json['price'],
      placeName: json['place_name'],
      address: json['address'],
      placeId: json['place_id'],
    );
  }
  @override
  List<Object?> get props => [];
}
