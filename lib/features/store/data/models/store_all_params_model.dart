import 'package:json_annotation/json_annotation.dart';
import 'package:shopfee/features/store/domain/entities/store_all_params_entity.dart';

part 'store_all_params_model.g.dart';

@JsonSerializable()
class StoreAllParamsModel {
  final bool all;
  final double lat;
  final double lng;
  final int page;
  final int size;
  final String? key;

  const StoreAllParamsModel({
    required this.all,
    required this.lat,
    required this.lng,
    required this.page,
    required this.size,
    this.key
  });

  factory StoreAllParamsModel.fromJson(Map<String, dynamic> json) {
    return _$StoreAllParamsModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$StoreAllParamsModelToJson(this);
  }

  factory StoreAllParamsModel.fromEntity(StoreAllParamsEntity entity) {
    return StoreAllParamsModel(
        all:entity.all, lat: entity.lat, lng: entity.lng, size: entity.size, page: entity.page, key: entity.key);
  }
}
