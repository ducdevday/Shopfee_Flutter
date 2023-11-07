import 'dart:ui';

import 'package:intl/intl.dart';

class StringConverterUtil {
  static String formattedDate(DateTime dateTime) {
    return DateFormat('MMMM dd, yyy').format(dateTime.toLocal());
  }

  static String formattedDate2(DateTime dateTime) {
    return DateFormat('dd/MM/yyyy').format(dateTime.toLocal());
  }

  static String formattedTime(DateTime dateTime) {
    return DateFormat('hh:mm a').format(dateTime.toLocal());
  }

  static String formattedQueryString(String s) {
    return s.trim().toLowerCase().replaceAll(' ', '');
  }
}
