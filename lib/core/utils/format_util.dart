import 'package:intl/intl.dart';

class FormatUtil {
  static String formattedDate(DateTime? dateTime) {
    if (dateTime == null) {
      return "";
    }
    return DateFormat('MMMM dd, yyy').format(dateTime.toLocal());
  }

  static String formattedDate2(DateTime? dateTime) {
    if (dateTime == null) {
      return "";
    }
    return DateFormat('dd/MM/yyyy').format(dateTime.toLocal());
  }

  static String formattedTime(DateTime? dateTime) {
    if (dateTime == null) {
      return "";
    }
    return DateFormat('hh:mm a').format(dateTime.toLocal());
  }

  static String formattedQueryString(String? s) {
    if (s == null) {
      return "";
    }
    return s.trim().toLowerCase().replaceAll(' ', '');
  }

  static String formatOriginalPhone(String? phone) {
    if (phone == null) {
      return "";
    }
    StringBuffer result = StringBuffer();

    for (int i = 0; i < phone.length; i++) {
      if (RegExp(r'[0-9]').hasMatch(phone[i])) {
        result.write(phone[i]);
      }
    }
    return result.toString();
  }

  static String formattedBirthDay(DateTime? dateTime) {
    if (dateTime == null) return "";
    return DateFormat('dd/MM/yyyy').format(dateTime.toLocal());
  }

  static String formatMoney(num? price) {
    if (price == null) {
      return "";
    }
    return '${NumberFormat.decimalPattern().format(price)}đ';
  }
}
