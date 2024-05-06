part of coupon_detail;

abstract class CouponDetailEvent extends Equatable {
  const CouponDetailEvent();
}

class CouponDetailLoadInformation extends CouponDetailEvent {
  final String couponId;

  const CouponDetailLoadInformation({
    required this.couponId,
  });

  @override
  List<Object> get props => [couponId];
}
