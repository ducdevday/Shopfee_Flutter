import 'package:geolocator/geolocator.dart';
import 'package:shopfee/data/repositories/geolocation/geolocation_respository_base.dart';

class GeolocationRepository extends GeolocationRepositoryBase {
  GeolocationRepository();

  @override
  Future<Position> getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    return position;
  }
}
