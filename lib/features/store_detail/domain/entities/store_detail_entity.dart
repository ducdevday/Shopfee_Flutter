import 'package:shopfee/core/common/enum/store_status.dart';
import 'package:shopfee/features/store_detail/data/models/store_detail_model.dart';

class StoreDetailEntity {
  final String id;
  final String? name;
  final String? phoneNumber;
  final String? imageUrl;
  final double? longitude;
  final double? latitude;
  final String? province;
  final String? district;
  final String? ward;
  final String? detail;
  final String? openTime;
  final String? closeTime;
  final StoreStatus? status;
  final bool? isValid;

  String get address => "$detail, $ward, $district, $province";

  const StoreDetailEntity({
    required this.id,
    this.name,
    this.phoneNumber,
    this.imageUrl,
    this.longitude,
    this.latitude,
    this.province,
    this.district,
    this.ward,
    this.detail,
    this.openTime,
    this.closeTime,
    this.status,
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
      province: model.province,
      district: model.district,
      ward: model.ward,
      detail: model.detail,
      openTime: model.openTime,
      closeTime: model.closeTime,
      status: model.status,
      isValid: model.isValid,
    );
  }
}
