part of coupon_detail;

abstract class CouponDetailState extends Equatable {
  const CouponDetailState();
}

class CouponDetailInitial extends CouponDetailState {
  @override
  List<Object> get props => [];
}

class CouponDetailLoadInProcess extends CouponDetailState {
  @override
  List<Object> get props => [];
}

class CouponDetailLoadSuccess extends CouponDetailState {
  final CouponDetailEntity coupon;

  const CouponDetailLoadSuccess({
    required this.coupon,
  });

  @override
  List<Object> get props => [coupon];
}

class CouponDetailLoadFailure extends CouponDetailState {
  @override
  List<Object> get props => [];
}