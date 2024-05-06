import 'package:shopfee/core/common/enum/coupon_type.dart';
import 'package:shopfee/features/coupon_in_cart/data/models/coupon_check_result_model.dart';
import 'package:shopfee/features/coupon_in_cart/domain/entities/reward_information_entity.dart';
import 'package:shopfee/features/coupon_in_cart/domain/entities/violated_condition_entity.dart';

class CouponCheckResultEntity{
  final CouponType? couponType;
  final ViolatedConditionEntity? violatedCondition;
  final RewardInformationEntity? reward;
  final bool? valid;

  const CouponCheckResultEntity({
    this.couponType,
    this.violatedCondition,
    this.reward,
    this.valid,
  });

  factory CouponCheckResultEntity.fromModel(CouponCheckResultModel model) {
    return CouponCheckResultEntity(
      couponType: model.couponType,
      violatedCondition: model.violatedCondition == null ? null :
          ViolatedConditionEntity.fromModel(model.violatedCondition!),
      reward: model.reward == null ? null : RewardInformationEntity.fromModel(model.reward!),
      valid: model.valid,
    );
  }
//
}