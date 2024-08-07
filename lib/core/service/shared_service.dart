import 'dart:io';

import 'package:path_provider/path_provider.dart';
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

  static String? getFCMTokenId(){
    return _pref.getString("fcmTokenId");
  }

  static void setFCMTokenId(String fcmTokenId) {
    _pref.setString("fcmTokenId", fcmTokenId);
  }

  static void removeFCMTokenId() {
    _pref.remove("fcmTokenId");
  }

  static void setToken(String userId, String accessToken) {
    setUserId(userId);
    setAccessToken(accessToken);
  }

  static void clearToken() {
    removeUserId();
    removeAccessToken();
    // removeFCMTokenId();
  }

  static String? getLanguage() {
    return _pref.getString("lang");
  }

  static Future<void> setLanguage(String lang) async{
    await _pref.setString("lang", lang);
  }

  static Future<void> initAppDocPath() async {
    final Directory appDocDir = await getApplicationDocumentsDirectory();
    final String appDocPath = appDocDir.path;
    SharedService.setAppDocPath(appDocPath);
  }
}
