import 'package:json_annotation/json_annotation.dart';
import 'package:shopfee/core/common/enum/store_status.dart';

part 'store_detail_model.g.dart';

@JsonSerializable()
class StoreDetailModel{
  final int? id;
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

  const StoreDetailModel({
    this.id,
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
    this.isValid
  });

  factory StoreDetailModel.fromJson(Map<String, dynamic> json) {
    return _$StoreDetailModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$StoreDetailModelToJson(this);
  }
}