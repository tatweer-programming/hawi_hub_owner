class Booking {
  final DateTime startTime;
  final DateTime endTime;

  const Booking({
    required this.startTime,
    required this.endTime,
  });

  factory Booking.fromJson(Map<String, dynamic> json) {
    return Booking(
      startTime: DateTime.parse(json['offlineReservationStartTime']),
      endTime: DateTime.parse(json['offlineReservationEndTime']),
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'reservationStartTime': startTime.toIso8601String(),
      'reservationEndTime': endTime.toIso8601String(),
    };
  }
}
