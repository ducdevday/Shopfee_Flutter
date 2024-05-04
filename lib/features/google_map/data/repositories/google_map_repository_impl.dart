import 'package:geolocator/geolocator.dart';
import 'package:shopfee/features/google_map/data/datasources/google_map_service.dart';
import 'package:shopfee/features/google_map/data/models/auto_complete_result_model.dart';
import 'package:shopfee/features/google_map/data/models/geo_result_model.dart';
import 'package:shopfee/features/google_map/domain/entities/auto_complete_result_entity.dart';
import 'package:shopfee/features/google_map/domain/entities/geo_result_entity.dart';
import 'package:shopfee/features/google_map/domain/repositories/google_map_repository.dart';

class GoogleMapRepositoryImpl implements GoogleMapRepository {
  final GoogleMapService _googleMapService;

  GoogleMapRepositoryImpl(this._googleMapService);

  @override
  Future<Position> getCurrentPosition() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    return position;
  }

  @override
  Future<GeoResultEntity?> getAddressFromName(String addressString) async {
    try {
      final response =
          await _googleMapService.getAddressFromName(addressString);
      final result = response.data['results'] as List<dynamic>?;
      // ? Lấy kết quả đầu tiên
      if (result != null && result.isNotEmpty) {
        final GeoResultModel geoResultModel =
            GeoResultModel.fromJson(result[0]);
        final GeoResultEntity geoResultEntity =
            GeoResultEntity.fromModel(geoResultModel);
        return geoResultEntity;
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<GeoResultEntity?> getAddressFromPosition(
      double lat, double lng) async {
    try {
      final response = await _googleMapService.getAddressFromPosition(lat, lng);
      final result = response.data['results'] as List<dynamic>?;
      // ? Lấy kết quả đầu tiên
      if (result != null && result.isNotEmpty) {
        final GeoResultModel geoResultModel =
            GeoResultModel.fromJson(result[0]);
        final GeoResultEntity geoResultEntity =
            GeoResultEntity.fromModel(geoResultModel);
        return geoResultEntity;
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<List<AutoCompleteResultEntity>> getAutoCompletePlaceList(
      String input) async {
    final response = await _googleMapService.getAutoCompletePlaceList(input);
    final predictions = response.data['predictions'] as List<dynamic>;
    final autoCompleteModelList =
        predictions.map((e) => AutoCompleteResultModel.fromJson(e)).toList();
    final autoCompleteEntityList = autoCompleteModelList
        .map((e) => AutoCompleteResultEntity.fromModel(e))
        .toList();
    return autoCompleteEntityList;
  }

  @override
  Future<GeoResultEntity> getAddressFromPlaceId(String placeId) async {
    final response = await _googleMapService.getAddressFromPlaceId(placeId);
    final result = response.data['results'] as List<dynamic>?;
    // ? Lấy kết quả đầu tiên
    final GeoResultModel geoResultModel = GeoResultModel.fromJson(result?[0]);
    final GeoResultEntity geoResultEntity =
        GeoResultEntity.fromModel(geoResultModel);
    return geoResultEntity;
  }

  @override
  Future<int> getDistanceFrom2Place(double originLat, double originLng,
      double destinationLat, double destinationLng) async {
    final response = await _googleMapService.getDistanceFrom2Place(
        originLat, originLng, destinationLat, destinationLng);
    final rows = response.data['rows'] as List<dynamic>?;
    final elements = rows?[0]["elements"] as List<dynamic>?;
    final distance = elements?[0]["distance"]["value"] as int;
    return distance;
  }
}
