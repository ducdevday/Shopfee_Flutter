part of coupon_in_cart;

abstract class CouponInCartState extends Equatable {
  const CouponInCartState();
}

class CouponInCartInitial extends CouponInCartState {
  @override
  List<Object> get props => [];
}

class CouponInCartLoadInProcess extends CouponInCartState {
  @override
  List<Object> get props => [];
}

class CouponInCartLoadSuccess extends CouponInCartState {
  final CouponInCartEntity couponInCart;
  final CartEntity currentCart;
  final String? shippingCouponChosenCode;
  final String? orderCouponChosenCode;
  final String? productCouponChosenCode;

  const CouponInCartLoadSuccess(
      {required this.couponInCart,
      required this.currentCart,
      this.shippingCouponChosenCode,
      this.orderCouponChosenCode,
      this.productCouponChosenCode});

  @override
  List<Object?> get props => [
        couponInCart,
        shippingCouponChosenCode,
        orderCouponChosenCode,
        productCouponChosenCode,
      ];

  CouponInCartLoadSuccess copyWith({
    CouponInCartEntity? couponInCart,
    CartEntity? currentCart,
    ValueGetter<String?>? shippingCouponChosenCode,
    ValueGetter<String?>? orderCouponChosenCode,
    ValueGetter<String?>? productCouponChosenCode,
  }) {
    return CouponInCartLoadSuccess(
      couponInCart: couponInCart ?? this.couponInCart,
      currentCart: currentCart ?? this.currentCart,
      shippingCouponChosenCode: shippingCouponChosenCode != null
          ? shippingCouponChosenCode()
          : this.shippingCouponChosenCode,
      orderCouponChosenCode: orderCouponChosenCode != null
          ? orderCouponChosenCode()
          : this.orderCouponChosenCode,
      productCouponChosenCode: productCouponChosenCode != null
          ? productCouponChosenCode()
          : this.productCouponChosenCode,
    );
  }
}

class CouponInCartLoadFailure extends CouponInCartState {
  @override
  List<Object> get props => [];
}
