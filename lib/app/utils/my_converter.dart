import 'package:intl/intl.dart';

class MyConverter {
  static String formattedDate(DateTime dateTime) {
    return DateFormat('MMMM dd, yyy').format(dateTime);
  }

  static String formattedTime(DateTime dateTime) {
    return DateFormat('kk:mm a').format(dateTime);
  }

  static String formattedQueryString(String s) {
    return s.trim().toLowerCase().replaceAll(' ', '');
  }
}
