import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:geolocator/geolocator.dart';

class PermissionUtil {
  static Future<bool> requestLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      EasyLoading.showInfo("Please enable GPS to create new address", duration: Duration(milliseconds: 2000));
      return false;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        EasyLoading.showInfo("Please grant location permission to create new address", duration: Duration(milliseconds: 2000));
        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      EasyLoading.showInfo("Please grant location permission to create new address", duration: Duration(milliseconds: 2000));
      return false;
    }

    return true;
  }
}
