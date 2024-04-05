import 'package:json_annotation/json_annotation.dart';
import 'package:shopfee/features/coupon_in_cart/data/models/combination_condition_model.dart';
import 'package:shopfee/features/coupon_in_cart/data/models/min_purchase_condition_model.dart';
import 'package:shopfee/features/coupon_in_cart/data/models/subject_condition_model.dart';
import 'package:shopfee/features/coupon_in_cart/data/models/usage_condition_model.dart';

part 'violated_condition_model.g.dart';

@JsonSerializable()
class ViolatedConditionModel {
  final MinPurchaseConditionModel? minPurchaseCondition;
  final List<UsageConditionModel>? usageConditionList;
  final List<SubjectConditionModel>? subjectConditionList;
  final List<CombinationConditionModel>? combinationConditionList;

  const ViolatedConditionModel({
    this.minPurchaseCondition,
    this.usageConditionList,
    this.subjectConditionList,
    this.combinationConditionList,
  });

  factory ViolatedConditionModel.fromJson(Map<String, dynamic> json) {
    return _$ViolatedConditionModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$ViolatedConditionModelToJson(this);
  }
}
