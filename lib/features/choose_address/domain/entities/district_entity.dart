import 'package:shopfee/features/choose_address/data/models/district_model.dart';

class DistrictEntity {
  final String? districtId;
  final String? districtName;
  final String? districtType;
  final num? lat;
  final num? lng;
  final String? provinceId;

  DistrictEntity(
      {required this.districtId,
      required this.districtName,
      required this.districtType,
      required this.lat,
      required this.lng,
      required this.provinceId});

  factory DistrictEntity.fromModel(DistrictModel model) {
    return DistrictEntity(
        districtId: model.districtId,
        districtName: model.districtName,
        districtType: model.districtType,
        lat: model.lat,
        lng: model.lng,
        provinceId: model.provinceId);
  }
}
