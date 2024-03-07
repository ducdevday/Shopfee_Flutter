import 'package:shared_preferences/shared_preferences.dart';

class SharedService {
  static late SharedPreferences _pref;

  static init() async {
    _pref = await SharedPreferences.getInstance();
  }

  static void removeAllKey() {
    _pref.clear();
  }

  static bool getSeenTooltip() {
    return _pref.getBool("seenToolTip") ?? false;
  }

  static void setSeenTooltip(bool value) {
    _pref.setBool("seenToolTip", value);
  }

  static String getAppDocPath() {
    return _pref.getString("appDocPath") ?? "";
  }

  static void setAppDocPath(String appDocPath) {
    _pref.setString("appDocPath", appDocPath);
  }

  static bool getIsFirstTime() {
    return _pref.getBool("isFirstTime") ?? true;
  }

  static void setIsFirstTime(bool isFirstTime) {
    _pref.setBool("isFirstTime", isFirstTime);
  }

  static String? getUserId() {
    return _pref.getString("userId");
  }

  static void setUserId(String userId) {
    _pref.setString("userId", userId);
  }

  static void removeUserId() {
    _pref.remove("userId");
  }

  static String? getAccessToken() {
    return _pref.getString("accessToken");
  }

  static void setAccessToken(String accessToken) {
    _pref.setString("accessToken", accessToken);
  }

  static void removeAccessToken() {
    _pref.remove("accessToken");
  }

  // static String? getGoogleIdToken() {
  //   return _pref.getString("googleIdToken");
  // }
  //
  // static void setGoogleIdToken(String googleIdToken) {
  //   _pref.setString("googleIdToken", googleIdToken);
  // }
  //
  // static void removeAccessToken() {
  //   _pref.remove("accessToken");
  // }

  static void setToken(String userId, String accessToken) {
    setUserId(userId);
    setAccessToken(accessToken);
  }

  static void clearToken() {
    removeUserId();
    removeAccessToken();
  }
}
