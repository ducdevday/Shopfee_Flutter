import 'package:json_annotation/json_annotation.dart';
import 'package:shopfee/core/common/enum/coupon_condition_type.dart';
import 'package:shopfee/features/coupon_in_cart/data/models/combination_condition_model.dart';
import 'package:shopfee/features/coupon_in_cart/data/models/min_purchase_condition_model.dart';
import 'package:shopfee/features/coupon_in_cart/data/models/subject_condition_model.dart';
import 'package:shopfee/features/coupon_in_cart/data/models/usage_condition_model.dart';

part 'coupon_condition_model.g.dart';

@JsonSerializable()
class CouponConditionModel {
  final ConditionType? type;
  final MinPurchaseConditionModel? minPurchaseCondition;
  final List<UsageConditionModel>? usageConditionList;
  final List<SubjectConditionModel>? subjectConditionList;
  final List<CombinationConditionModel>? combinationConditionList;

  const CouponConditionModel({
    this.type,
    this.minPurchaseCondition,
    this.usageConditionList,
    this.subjectConditionList,
    this.combinationConditionList,
  });

  factory CouponConditionModel.fromJson(Map<String, dynamic> json) {
    return _$CouponConditionModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$CouponConditionModelToJson(this);
  }
}
