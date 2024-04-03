import 'package:shopfee/core/common/enum/store_status.dart';
import 'package:shopfee/features/store_detail/data/models/store_detail_model.dart';

class StoreDetailEntity {
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

  const StoreDetailEntity({
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

  factory StoreDetailEntity.fromModel(StoreDetailModel model) {
    return StoreDetailEntity(
      id: model.id!,
      name: model.name,
      phoneNumber: model.phoneNumber,
      imageUrl: model.imageUrl,
      longitude: model.longitude,
      latitude: model.latitude,
      openTime: model.openTime,
      closeTime: model.closeTime,
      fullAddress: model.fullAddress,
      isValid: model.isValid,
    );
  }
}
