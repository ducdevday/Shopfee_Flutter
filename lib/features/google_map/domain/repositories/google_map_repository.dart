import 'package:geolocator/geolocator.dart';
import 'package:shopfee/features/google_map/domain/entities/geo_result_entity.dart';

abstract class GoogleMapRepository {
  Future<Position> getCurrentPosition();
  Future<GeoResultEntity?> getAddressFromName(String addressString);
  Future<GeoResultEntity?> getAddressFromPosition(double lat, double lng);
}