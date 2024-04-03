import 'package:flutter/material.dart';
import 'global_keys.dart';

class NavigationUtil {
  static NavigatorState? get _navigatorKey => navigatorKey.currentState;

  static Future push(Widget page) async {
    return await _navigatorKey?.push(MaterialPageRoute(builder: (_) => page));
  }

  static Future pushNamed(String route, {Object? arguments}) async {
    return await _navigatorKey?.pushNamed(route, arguments: arguments);
  }

  static Future pushAndRemoveUntil(Widget page) async {
    return await _navigatorKey?.pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => page), (route) => false);
  }

  static Future pushNamedAndRemoveUntil(String route,
      {Object? arguments}) async {
    return await _navigatorKey?.pushNamedAndRemoveUntil(route, (r) => false,
        arguments: arguments);
  }

  static pop({Object? result}) {
    _navigatorKey?.pop(result);
  }
}
