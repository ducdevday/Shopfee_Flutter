part of coupon;

abstract class CouponEvent extends Equatable {
  const CouponEvent();
}

class CouponLoadInformation extends CouponEvent {

  const CouponLoadInformation();

  @override
  List<Object> get props => [];
}
