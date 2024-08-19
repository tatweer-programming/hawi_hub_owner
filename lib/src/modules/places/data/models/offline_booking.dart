import 'package:equatable/equatable.dart';

class OfflineBooking  extends Equatable{
  final int placeId;
   final DateTime startTime ;
   final DateTime endTime ;

  OfflineBooking({required this.placeId,required this.startTime,required this.endTime});

  factory OfflineBooking.fromJson(Map<String, dynamic> json) {
    return OfflineBooking(
      placeId: json['stadiumId'],
      startTime: DateTime.parse(json['offlineReservationStartTime']),
      endTime: DateTime.parse(json['offlineReservationEndTime']),
    );
  }

  @override
  List<Object?> get props => [];
}