import 'package:json_annotation/json_annotation.dart';

part 'district_model.g.dart';

@JsonSerializable()
class DistrictModel {
  @JsonKey(name: "district_id")
  final String? districtId;
  @JsonKey(name: "district_name")
  final String? districtName;
  @JsonKey(name: "district_type")
  final String? districtType;
  @JsonKey(name: "lat")
  final num? lat;
  @JsonKey(name: "lng")
  final num? lng;
  @JsonKey(name: "province_id")
  final String? provinceId;

  DistrictModel(
      {required this.districtId,
      required this.districtName,
      required this.districtType,
      required this.lat,
      required this.lng,
      required this.provinceId});

  factory DistrictModel.fromJson(Map<String, dynamic> json) {
    return _$DistrictModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$DistrictModelToJson(this);
  }
}
