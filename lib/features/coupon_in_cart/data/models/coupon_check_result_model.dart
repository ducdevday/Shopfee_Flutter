import 'package:json_annotation/json_annotation.dart';
import 'package:shopfee/core/common/enum/coupon_type.dart';
import 'package:shopfee/features/coupon_in_cart/data/models/reward_information_model.dart';
import 'package:shopfee/features/coupon_in_cart/data/models/violated_condition_model.dart';

part 'coupon_check_result_model.g.dart';

@JsonSerializable()
class CouponCheckResultModel {
  final CouponType? couponType;
  final ViolatedConditionModel? violatedCondition;
  final RewardInformationModel? reward;
  final bool? valid;

  const CouponCheckResultModel({
    this.couponType,
    this.violatedCondition,
    this.reward,
    this.valid,
  });

  factory CouponCheckResultModel.fromJson(Map<String, dynamic> json) {
    return _$CouponCheckResultModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$CouponCheckResultModelToJson(this);
  }
}
