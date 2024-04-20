import 'package:equatable/equatable.dart';

class BookingRequest extends Equatable {
// use data
  final int userId;
  final String userName;
  final String userImage;

  // request data
  final int id;
  final DateTime startTime;
  final DateTime endTime;
  final double price;

  // place data
  final String placeName;
  final String address;

  const BookingRequest({
    required this.userId,
    required this.userName,
    required this.userImage,
    required this.id,
    required this.startTime,
    required this.endTime,
    required this.price,
    required this.placeName,
    required this.address,
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
    );
  }
  @override
  List<Object?> get props => [];
}
