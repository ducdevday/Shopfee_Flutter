import 'package:shopfee/features/google_map/data/models/geo_result_model.dart';
import 'package:shopfee/features/template/data/models/template_model.dart';

class GeoResultEntity {
  final String formattedAddress;
  final double lat;
  final double lng;

  const GeoResultEntity({
    required this.formattedAddress,
    required this.lat,
    required this.lng,
  });

  factory GeoResultEntity.fromModel(GeoResultModel model) {
    return GeoResultEntity(
        formattedAddress: model.formattedAddress,
        lat: model.lat,
        lng: model.lng);
  }
}
