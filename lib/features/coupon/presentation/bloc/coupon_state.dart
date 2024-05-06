part of coupon;

abstract class CouponState extends Equatable {
  const CouponState();
}

class CouponInitial extends CouponState {
  @override
  List<Object> get props => [];
}

class CouponLoadInProcess extends CouponState {
  @override
  List<Object> get props => [];
}

class CouponLoadSuccess extends CouponState {
  final List<CouponByTypeEntity> shippingCoupons;
  final List<CouponByTypeEntity> orderCoupons;
  final List<CouponByTypeEntity> productCoupons;

  const CouponLoadSuccess({
    this.shippingCoupons = const [],
    this.orderCoupons = const [],
    this.productCoupons = const [],
  });

  List<CouponByTypeEntity> getCouponListByType(CouponType type) {
    switch (type) {
      case (CouponType.SHIPPING):
        return shippingCoupons;
      case (CouponType.PRODUCT):
        return productCoupons;
      case (CouponType.ORDER):
        return orderCoupons;
    }
  }

  int getCouponListLengthByType(CouponType type) {
    switch (type) {
      case (CouponType.SHIPPING):
        return shippingCoupons.length;
      case (CouponType.PRODUCT):
        return productCoupons.length;
      case (CouponType.ORDER):
        return orderCoupons.length;
    }
  }

  @override
  List<Object> get props => [
        shippingCoupons,
        orderCoupons,
        productCoupons,
      ];
}

class CouponLoadFailure extends CouponState {
  @override
  List<Object> get props => [];
}
