import 'package:shopfee/features/preferential/domain/entities/coupon_by_type_entity.dart';

abstract class PreferentialRepository {
  Future<List<CouponByTypeEntity>> getTopCoupons(int quantity);
}
