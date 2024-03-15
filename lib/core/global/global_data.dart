import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shopfee/core/config/app_path.dart';

class GlobalData {
  static final ins = GlobalData._();

  GlobalData._();

  late BitmapDescriptor customIcon;
  Position? currentPosition;

  Future<void> createCustomIcon() async {
    customIcon = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(size: Size(12, 12)), AppPath.icStoreMark);
  }

  Future<Position> getCurrentPosition() async {
    var isOkLocation = await Geolocator.checkPermission();

    if ((isOkLocation == LocationPermission.whileInUse ||
        isOkLocation == LocationPermission.always) && currentPosition == null) {
      currentPosition = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
    }
    return currentPosition!;
  }
}
