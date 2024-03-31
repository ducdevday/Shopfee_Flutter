import 'package:shopfee/core/errors/app_exception.dart';
import 'package:shopfee/features/cart/domain/entities/cart_entity.dart';
import 'package:shopfee/features/coupon_in_cart/domain/entities/coupon_in_cart_entity.dart';
import 'package:shopfee/features/coupon_in_cart/domain/repositories/coupon_in_cart_repository.dart';
import 'package:shopfee/features/template/domain/entities/template_entity.dart';
import 'package:shopfee/features/template/domain/repositories/template_repository.dart';

abstract class CouponInCartUseCase {
  Future<CouponInCartEntity> getCouponListInCart(CartEntity cart);
}

class CouponInCartUseCaseImpl extends CouponInCartUseCase {
  final CouponInCartRepository _couponInCartRepository;

  CouponInCartUseCaseImpl(this._couponInCartRepository);

  @override
  Future<CouponInCartEntity> getCouponListInCart(CartEntity cart) async {
    return await _couponInCartRepository.getCouponListInCart(cart);
  }
}
