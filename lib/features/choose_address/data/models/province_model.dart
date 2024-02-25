import 'package:json_annotation/json_annotation.dart';

part 'province_model.g.dart';

@JsonSerializable()
class ProvinceModel {
  @JsonKey(name: "province_id")
  final String? provinceId;
  @JsonKey(name: "province_name")
  final String? provinceName;
  @JsonKey(name: "province_type")
  final String? provinceType;

  const ProvinceModel({
    required this.provinceId,
    required this.provinceName,
    required this.provinceType,
  });

  factory ProvinceModel.fromJson(Map<String, dynamic> json) {
    return _$ProvinceModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$ProvinceModelToJson(this);
  }
}
