import 'package:shopfee/features/cart/domain/entities/cart_entity.dart';
import 'package:shopfee/features/coupon_in_cart/domain/entities/coupon_in_cart_entity.dart';
import 'package:shopfee/features/coupon_in_cart/domain/entities/reward_information_entity.dart';
import 'package:shopfee/features/coupon_in_cart/domain/repositories/coupon_in_cart_repository.dart';

abstract class CouponInCartUseCase {
  Future<CouponInCartEntity> getCouponListInCart(
      CartEntity cart,
      String? shippingCouponCode,
      String? orderCouponCode,
      String? productCouponCode);
}

class CouponInCartUseCaseImpl extends CouponInCartUseCase {
  final CouponInCartRepository _couponInCartRepository;

  CouponInCartUseCaseImpl(this._couponInCartRepository);

  @override
  Future<CouponInCartEntity> getCouponListInCart(
      CartEntity cart,
      String? shippingCouponCode,
      String? orderCouponCode,
      String? productCouponCode) async {
    return await _couponInCartRepository.getCouponListInCart(cart, shippingCouponCode, orderCouponCode, productCouponCode);
  }
}
