import 'package:intl/intl.dart';

String utcToLocal(String utcDate) {
  DateTime utcDateTime = DateTime.parse(utcDate);
  DateTime egyptDateTime = utcDateTime.toUtc().add(const Duration(hours: 6));
  return DateFormat('hh:mm a').format(egyptDateTime);
}