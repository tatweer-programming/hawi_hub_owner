import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class Day extends Equatable {
  final int dayOfWeek;
  final TimeOfDay startTime;
  final TimeOfDay endTime;

  const Day({required this.dayOfWeek, required this.startTime, required this.endTime});

  bool isWeekend() {
    return startTime.hour == 0 && startTime.minute == 0 && endTime.hour == 0 && endTime.minute == 0;
  }

  bool isAllDay() {
    return startTime.hour == 0 &&
        startTime.minute == 0 &&
        endTime.hour == 23 &&
        endTime.minute == 59;
  }

  // isBookingAvailable(int startTime, int endTime) {
  //   if (!isWeekend()) {
  //     return startTime >= this.startTime! && endTime <= this.endTime!;
  //   }
  // }

  factory Day.fromJson(Map<String, dynamic> json) {
    return Day(
        dayOfWeek: json['dayOfWeek'],
        startTime: json['startTime'].toString().parseToTimeOfDay(),
        endTime: json['endTime'].toString().parseToTimeOfDay());
  }
  Map toJson() => {
        "dayOfWeek": dayOfWeek,
        "startTime": {
          "ticks": 0,
          "days": 0,
          "hours": startTime.hour,
          "milliseconds": 0,
          "minutes": startTime.minute,
          "seconds": 0
        },
        "endTime": {
          "ticks": 0,
          "days": 0,
          "hours": endTime.hour,
          "milliseconds": 0,
          "minutes": endTime.minute,
          "seconds": 0
        }
      };

  @override
  List<Object?> get props => [];
  bool isBookingAllowed(DateTime bookingStart, DateTime bookingEnd) {
    // تحقق مما إذا كان وقت الحجز يقع ضمن وقت عمل الملعب
    TimeOfDay startBooking = TimeOfDay.fromDateTime(bookingStart);
    TimeOfDay endBooking = TimeOfDay.fromDateTime(bookingEnd);
    return startBooking.hour >= startTime.hour &&
        startBooking.minute >= startTime.minute &&
        endBooking.hour <= endTime.hour &&
        endBooking.minute <= endTime.minute;
    return false;
  }
}

extension TimeOfDayExtension on String {
  TimeOfDay? tryParseToTimeOfDay() {
    final List<String> parts = split(":");

    final int? hour = int.tryParse(parts[0]);
    final int? minute = int.tryParse(parts[1]);

    if (hour == null || minute == null || hour < 0 || hour >= 23 || minute < 0 || minute >= 59) {
      return null;
    }
    return TimeOfDay(hour: hour, minute: minute);
  }

  TimeOfDay parseToTimeOfDay() {
    final List<String> parts = split(":");
    return TimeOfDay(hour: int.parse(parts[0]), minute: int.parse(parts[1]));
  }
}
