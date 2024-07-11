import 'package:intl/intl.dart';

String? utcToLocal(String? utcDate) {
  print(utcDate);
  if (utcDate == null) return null;
  var date = DateTime.parse(utcDate);
  var formattedDate = DateFormat.yMMMd().add_jm().format(date);
  return formattedDate;
}
