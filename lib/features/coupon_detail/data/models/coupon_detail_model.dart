import 'package:json_annotation/json_annotation.dart';
import 'package:shopfee/core/common/enum/coupon_type.dart';
import 'package:shopfee/features/coupon_detail/data/models/coupon_condition_model.dart';

part 'coupon_detail_model.g.dart';

@JsonSerializable()
class CouponDetailModel{
  final String? code;
  final CouponType? type;
  final String? description;
  final List<CouponConditionModel>? conditionList;
  final DateTime? startDate;
  final DateTime? expirationDate;

  const CouponDetailModel({
    this.code,
    this.type,
    this.description,
    this.conditionList,
    this.startDate,
    this.expirationDate,
  });

  factory CouponDetailModel.fromJson(Map<String, dynamic> json) {
    return _$CouponDetailModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$CouponDetailModelToJson(this);
  }
}