class Booking {
  final DateTime startTime;
  final DateTime endTime;

  const Booking({
    required this.startTime,
    required this.endTime,
  });

  factory Booking.fromJson(Map<String, dynamic> json) {
    return Booking(
      startTime: DateTime.parse(json['reservationStartTime']),
      endTime: DateTime.parse(json['reservationEndTime']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'reservationStartTime': startTime.toIso8601String(),
      'reservationEndTime': endTime.toIso8601String(),
    };
  }

  bool isConflicting(
    Booking newBooking,
  ) {
    return (newBooking.startTime.isBefore(endTime) ||
            newBooking.startTime.isAtSameMomentAs(endTime)) &&
        (newBooking.endTime.isAfter(startTime) ||
            newBooking.endTime.isAtSameMomentAs(startTime));
  }
}
