import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shopfee/core/config/app_path.dart';

class GlobalData {
  static final ins = GlobalData._();

  GlobalData._();

  late BitmapDescriptor customIcon;

  Future<void> createCustomIcon() async {
    customIcon = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(size: Size(12, 12)), AppPath.icStoreMark);
  }
}
