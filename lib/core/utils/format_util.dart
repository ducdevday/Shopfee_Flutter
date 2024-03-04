import 'package:intl/intl.dart';

class FormatUtil {
  static String formatDate(DateTime? dateTime) {
    if (dateTime == null) {
      return "";
    }
    return DateFormat('MMMM dd, yyy').format(dateTime.toLocal());
  }

  static String formatDate2(DateTime? dateTime) {
    if (dateTime == null) {
      return "";
    }
    return DateFormat('dd/MM/yyyy').format(dateTime.toLocal());
  }

  static String formatTime(DateTime? dateTime) {
    if (dateTime == null) {
      return "";
    }
    return DateFormat('hh:mm a').format(dateTime.toLocal());
  }

  static String formatQueryString(String? s) {
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

  static String formatBirthDay(DateTime? dateTime) {
    if (dateTime == null) return "";
    return DateFormat('dd/MM/yyyy').format(dateTime.toLocal());
  }

  static String formatMoney(num? price) {
    if (price == null) {
      return "";
    }
    return '${NumberFormat.decimalPattern().format(price)}đ';
  }

  static String formatMoneyByK(num? price) {
    if (price == null) {
      return "";
    }
    String formattedPrice = NumberFormat.decimalPattern().format(price);
    formattedPrice = formattedPrice.replaceAll(RegExp(r'(?<=\d)0{3}\b'), '');
    return '${formattedPrice}k';
  }

  static String formatSize(String size) {
    switch (size) {
      case "SMALL":
        return "Small";
      case "MEDIUM":
        return "Medium";
      case "LARGE":
        return "Large";
      default:
        return "One Size";
    }
  }
}
