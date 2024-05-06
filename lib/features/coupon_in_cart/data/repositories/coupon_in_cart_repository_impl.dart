import 'package:shopfee/core/common/models/result.dart';
import 'package:shopfee/features/cart/data/models/cart_model.dart';
import 'package:shopfee/features/cart/domain/entities/cart_entity.dart';
import 'package:shopfee/features/cart/domain/entities/cart_extension.dart';
import 'package:shopfee/features/coupon_in_cart/data/datasources/coupon_in_cart_service.dart';
import 'package:shopfee/features/coupon_in_cart/data/models/coupon_in_cart_model.dart';
import 'package:shopfee/features/coupon_in_cart/domain/entities/coupon_in_cart_entity.dart';
import 'package:shopfee/features/coupon_in_cart/domain/repositories/coupon_in_cart_repository.dart';

class CouponInCartRepositoryImpl implements CouponInCartRepository {
  final CouponInCartService _couponInCartService;

  CouponInCartRepositoryImpl(this._couponInCartService);

  @override
  Future<CouponInCartEntity> getCouponListInCart(
      CartEntity cart,
      String? shippingCouponCode,
      String? orderCouponCode,
      String? productCouponCode) async {
    final response = await _couponInCartService.getCouponListInCart(
        CartModel.fromEntity(cart),
        cart.totalItemPrice,
        cart.getCartTotalPrice(),
        shippingCouponCode,
        orderCouponCode,
        productCouponCode);
    final result = Result(
      success: response.data["success"],
      message: response.data["message"],
      data: response.data["data"],
    );
    final couponInCartModel = CouponInCartModel.fromJson(result.data!);
    final couponInCartEntity = CouponInCartEntity.fromModel(couponInCartModel);
    return couponInCartEntity;
  }
}
