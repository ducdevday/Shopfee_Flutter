import 'package:shopfee/core/utils/format_util.dart';

class ValidateFieldUtil {
  static bool validateName(String name) {
    // final RegExp nameRegRxp = RegExp(r'^[a-zA-Z]{2,12}(?: [a-zA-Z]+){0,2}$');
    final RegExp nameRegRxp = RegExp(r'^(?!.*\s{3,})(?!.*[^a-zA-Z\s]).{2,12}$');
    if (!nameRegRxp.hasMatch(name)) {
      return false;
    }
    return true;
  }

  static bool validateEmail(String email) {
    final RegExp emailRegExp = RegExp(
      r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$',
    );
    if (!emailRegExp.hasMatch(email)) {
      return false;
    }
    return true;
  }

  static bool validatePassword(String password) {
    if (password.length < 6) {
      return false;
    }
    return true;
  }

  static bool validatePhone(String phone) {
    phone = FormatUtil.formatOriginalPhone(phone);
    if (phone.length != 10) {
      return false;
    }
    return true;
  }

  static bool validateAddress(String address) {
    if (address.isEmpty) {
      return false;
    }
    return true;
  }
}
