part of coupon;

class CouponBloc extends Bloc<CouponEvent, CouponState> {
  final CouponUseCase _couponUseCase;

  CouponBloc(this._couponUseCase) : super(CouponInitial()) {
    on<CouponLoadInformation>(_onCouponLoadInformation);
  }

  FutureOr<void> _onCouponLoadInformation(
      CouponLoadInformation event, Emitter<CouponState> emit) async {
    try {
      emit(CouponLoadInProcess());
      final response = await Future.wait([
        _couponUseCase.getCouponsByType(CouponType.SHIPPING),
        _couponUseCase.getCouponsByType(CouponType.ORDER),
        _couponUseCase.getCouponsByType(CouponType.PRODUCT)
      ]);
      final List<CouponByTypeEntity> shippingCoupons = response[0];
      final List<CouponByTypeEntity> orderCoupons = response[1];
      final List<CouponByTypeEntity> productCoupons = response[2];
      await Future.delayed(Duration(seconds: 1));
      emit(CouponLoadSuccess(
          shippingCoupons: shippingCoupons,
          orderCoupons: orderCoupons,
          productCoupons: productCoupons));
    } catch (e) {
      emit(CouponLoadFailure());
    }
  }
}
