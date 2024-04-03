import 'package:shopfee/features/cart/domain/entities/cart_entity.dart';
import 'package:shopfee/features/coupon_in_cart/domain/entities/coupon_in_cart_entity.dart';

abstract class CouponInCartRepository {
  Future<CouponInCartEntity> getCouponListInCart(CartEntity cart);
}
