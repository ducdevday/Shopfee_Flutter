import 'package:json_annotation/json_annotation.dart';
import 'package:shopfee/features/store/domain/entities/store_all_params_entity.dart';

part 'store_all_params_model.g.dart';

@JsonSerializable()
class StoreAllParamsModel {
  final double lat;
  @JsonKey(name: "lon")
  final double lng;
  final int page;
  final int size;

  const StoreAllParamsModel({
    required this.lat,
    required this.lng,
    required this.page,
    required this.size,
  });

  factory StoreAllParamsModel.fromJson(Map<String, dynamic> json) {
    return _$StoreAllParamsModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$StoreAllParamsModelToJson(this);
  }

  factory StoreAllParamsModel.fromEntity(StoreAllParamsEntity entity) {
    return StoreAllParamsModel(
        lat: entity.lat, lng: entity.lng, size: entity.size, page: entity.page);
  }
}
