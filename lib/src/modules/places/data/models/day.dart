import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class Day extends Equatable {
  final int dayOfWeek;
  final TimeOfDay startTime;
  final TimeOfDay endTime;

  const Day(
      {required this.dayOfWeek,
      required this.startTime,
      required this.endTime});

  bool isWeekend() {
    return startTime.hour == 0 &&
        startTime.minute == 0 &&
        endTime.hour == 0 &&
        endTime.minute == 0;
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
        "startTime": startTime.toStr(),
        "endTime": endTime.toStr(),
      };

  @override
  List<Object?> get props => [dayOfWeek, startTime, endTime];
  bool isBookingAllowed(DateTime bookingStart, DateTime bookingEnd) {
    // تحقق مما إذا كان وقت الحجز يقع ضمن وقت عمل الملعب
    TimeOfDay startBooking = TimeOfDay.fromDateTime(bookingStart);
    TimeOfDay endBooking = TimeOfDay.fromDateTime(bookingEnd);
    return startBooking.hour >= startTime.hour &&
        startBooking.minute >= startTime.minute &&
        endBooking.hour <= endTime.hour &&
        endBooking.minute <= endTime.minute;
  }
}

extension TimeOfDayExtension on String {
  TimeOfDay? tryParseToTimeOfDay() {
    try {
      final parts = split(':');
      final hour = int.parse(parts[0]);
      final minute = int.parse(parts[1]);
      return TimeOfDay(hour: hour, minute: minute);
    } catch (e) {
      return null;
    }
  }

  TimeOfDay parseToTimeOfDay() {
    final List<String> parts = split(":");
    return TimeOfDay(hour: int.parse(parts[0]), minute: int.parse(parts[1]));
  }
}

extension TimeOfDayExtensionToStr on TimeOfDay {
  String toStr() {
    return "${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}:00";
  }
}
