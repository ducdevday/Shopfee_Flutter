import 'package:json_annotation/json_annotation.dart';

part 'ward_model.g.dart';

@JsonSerializable()
class WardModel {
  @JsonKey(name: "district_id")
  final String districtId;
  @JsonKey(name: "ward_id")
  final String wardId;
  @JsonKey(name: "ward_name")
  final String wardName;
  @JsonKey(name: "ward_type")
  final String wardType;

  const WardModel({
    required this.districtId,
    required this.wardId,
    required this.wardName,
    required this.wardType,
  });

  factory WardModel.fromJson(Map<String, dynamic> json) {
    return _$WardModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$WardModelToJson(this);
  }
}
