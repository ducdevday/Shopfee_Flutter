import 'package:geolocator/geolocator.dart';

abstract class GeolocationRepositoryBase{
  Future<Position?>  getCurrentLocation() async{}
}