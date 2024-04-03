import 'package:json_annotation/json_annotation.dart';
import 'package:shopfee/features/coupon_in_cart/data/models/combination_condition_model.dart';
import 'package:shopfee/features/coupon_in_cart/data/models/min_purchase_condition_model.dart';
import 'package:shopfee/features/coupon_in_cart/data/models/subject_condition_model.dart';
import 'package:shopfee/features/coupon_in_cart/data/models/usage_condition_model.dart';

part 'coupon_information_model.g.dart';

@JsonSerializable()
class CouponInformationModel {
  final String? couponId;
  final String? code;
  final String? description;
  final DateTime? expirationDate;
  final bool? valid;
  final MinPurchaseConditionModel? minPurchaseCondition;
  final List<UsageConditionModel>? usageConditionList;
  final List<SubjectConditionModel>? subjectConditionList;
  final List<CombinationConditionModel>? combinationConditionList;

  const CouponInformationModel({
    this.couponId,
    this.code,
    this.description,
    this.expirationDate,
    this.valid,
    this.minPurchaseCondition,
    this.usageConditionList,
    this.subjectConditionList,
    this.combinationConditionList,
  });

  factory CouponInformationModel.fromJson(Map<String, dynamic> json) {
    return _$CouponInformationModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$CouponInformationModelToJson(this);
  }
}
