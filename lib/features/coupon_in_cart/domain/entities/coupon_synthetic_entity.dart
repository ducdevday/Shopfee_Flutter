import 'package:shopfee/core/common/enum/coupon_type.dart';
import 'package:shopfee/features/coupon_in_cart/domain/entities/reward_information_entity.dart';

class CouponSyntheticEntity{
  final String couponId;
  final String code;
  final String description;
  final RewardInformationEntity rewardInformation;

  const CouponSyntheticEntity( {
    required this.couponId,
    required this.code,
    required this.description,
    required this.rewardInformation,
  });
}