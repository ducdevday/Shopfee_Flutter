part of coupon_in_cart;

abstract class CouponInCartEvent extends Equatable {
  const CouponInCartEvent();
}

class CouponInCartLoadInformation extends CouponInCartEvent {
  final CartEntity cart;

  const CouponInCartLoadInformation({
    required this.cart,
  });

  @override
  List<Object> get props => [cart];
}