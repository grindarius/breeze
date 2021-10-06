import 'package:intl/intl.dart';

int daysBetween(DateTime from, DateTime to) {
  from = DateTime(from.year, from.month, from.day);
  to = DateTime(to.year, to.month, to.day);
  return (to.difference(from).inHours / 24).round();
}

List<DateTime> getDaysInBetween(DateTime from, DateTime to) {
  List<DateTime> days = [];
  for (int i = 0; i <= to.difference(from).inDays; i++) {
    days.add(from.add(Duration(days: i)));
  }
  return days;
}

DateFormat hiveDateFormat = DateFormat('yyyy-MM-dd');
