

import 'package:shopfee/core/common/enum/coupon_type.dart';
import 'package:shopfee/features/preferential/domain/entities/coupon_by_type_entity.dart';

abstract class CouponRepository {
  Future<List<CouponByTypeEntity>> getCouponsByType(CouponType type);
}