import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

class Day extends Equatable {
  final int dayId;
  final int? startTime;
  final int? endTime;

  const Day({required this.dayId, this.startTime, this.endTime});

  bool isWeekend() {
    return startTime == null && endTime == null;
  }

  bool isAllDay() {
    return startTime == 0 && endTime == 24;
  }

  isBookingAvailable(int startTime, int endTime) {
    if (!isWeekend()) {
      return startTime >= this.startTime! && endTime <= this.endTime!;
    }
  }

  factory Day.fromJson(MapEntry<int, List<int?>> json) {
    return Day(dayId: json.key, startTime: json.value[0], endTime: json.value[1]);
  }
  Map<int, List<int?>> toJson() => {
        dayId: [startTime, endTime]
      };

  @override
  List<Object?> get props => [];
}
