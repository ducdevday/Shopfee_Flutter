import 'package:geolocator/geolocator.dart';
import 'package:shopfee/features/google_map/domain/entities/auto_complete_result_entity.dart';
import 'package:shopfee/features/google_map/domain/entities/geo_result_entity.dart';

abstract class GoogleMapRepository {
  Future<Position> getCurrentPosition();
  Future<List<AutoCompleteResultEntity>> getAutoCompletePlaceList(String input);
  Future<GeoResultEntity> getAddressFromPlaceId(String placeId);
  Future<int> getDistanceFrom2Place(double originLat, double originLng,
      double destinationLat, double destinationLng);
  Future<GeoResultEntity?> getAddressFromName(String addressString);
  Future<GeoResultEntity?> getAddressFromPosition(double lat, double lng);
}