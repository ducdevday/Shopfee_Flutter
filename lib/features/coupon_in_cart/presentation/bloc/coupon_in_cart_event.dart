part of coupon_in_cart;

abstract class CouponInCartEvent extends Equatable {
  const CouponInCartEvent();
}

class CouponInCartLoadInitInformation extends CouponInCartEvent {
  final CartEntity cart;
  final String? shippingCouponChosenCode;
  final String? orderCouponChosenCode;
  final String? productCouponChosenCode;

  const CouponInCartLoadInitInformation({
    required this.cart,
    required this.shippingCouponChosenCode,
    required this.orderCouponChosenCode,
    required this.productCouponChosenCode,
  });

  @override
  List<Object?> get props =>
      [
        cart,
        shippingCouponChosenCode,
        orderCouponChosenCode,
        productCouponChosenCode,
      ];
}

class CouponInCartChooseItem extends CouponInCartEvent {
  final String? couponCode;
  final CouponType couponType;

  const CouponInCartChooseItem({
    required this.couponCode,
    required this.couponType,
  });

  @override
  List<Object?> get props => [couponCode, couponType];
}

class CouponInCartLoadChosenInformation extends CouponInCartEvent {
  @override
  List<Object> get props => [];
}