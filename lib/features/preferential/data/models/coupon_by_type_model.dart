import 'package:json_annotation/json_annotation.dart';
import 'package:shopfee/core/common/enum/coupon_type.dart';

part 'coupon_by_type_model.g.dart';

@JsonSerializable()
class CouponByTypeModel{
  final String? id;
  final String? description;
  final DateTime? startDate;
  final DateTime? expirationDate;
  final CouponType? type;

  const CouponByTypeModel({
    this.id,
    this.description,
    this.startDate,
    this.expirationDate,
    this.type,
  });

  factory CouponByTypeModel.fromJson(Map<String, dynamic> json) {
    return _$CouponByTypeModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$CouponByTypeModelToJson(this);
  }
}