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

  const CouponInCartLoadSuccess({
    required this.couponInCart,
  });

  @override
  List<Object> get props => [couponInCart];
}

class CouponInCartLoadFailure extends CouponInCartState {
  @override
  List<Object> get props => [];
}