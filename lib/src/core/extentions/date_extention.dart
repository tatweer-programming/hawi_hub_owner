extension DateExtention on DateTime {
  String get toDateString => "$year-$month-$day";
  String get toTimeString => "$hour:$minute";
}
