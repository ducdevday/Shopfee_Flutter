

import 'package:shopfee/features/coupon_detail/domain/entities/coupon_detail_entity.dart';

abstract class CouponDetailRepository {
  Future<CouponDetailEntity> getCouponDetail(String couponId);
}