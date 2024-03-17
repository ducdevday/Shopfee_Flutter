import 'package:json_annotation/json_annotation.dart';
import 'package:shopfee/core/common/enum/store_status.dart';
import 'package:shopfee/features/store_detail/domain/entities/store_detail_entity.dart';

part 'store_detail_model.g.dart';

@JsonSerializable()
class StoreDetailModel {
  final String? id;
  final String? name;
  final String? phoneNumber;
  final String? imageUrl;
  final double? longitude;
  final double? latitude;
  final String? openTime;
  final String? closeTime;
  final String? fullAddress;
  final bool? isValid;

  const StoreDetailModel({
    this.id,
    this.name,
    this.phoneNumber,
    this.imageUrl,
    this.longitude,
    this.latitude,
    this.openTime,
    this.closeTime,
    this.fullAddress,
    this.isValid,
  });

  factory StoreDetailModel.fromJson(Map<String, dynamic> json) {
    return _$StoreDetailModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$StoreDetailModelToJson(this);
  }

  factory StoreDetailModel.fromEntity(StoreDetailEntity entity) {
    return StoreDetailModel(
        id: entity.id,
        name: entity.name,
        phoneNumber: entity.phoneNumber,
        imageUrl: entity.imageUrl,
        longitude: entity.longitude,
        latitude: entity.latitude,
        openTime: entity.openTime,
        closeTime: entity.closeTime,
        fullAddress: entity.fullAddress,
        isValid: entity.isValid);
  }


}
