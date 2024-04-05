part of coupon_detail;

class CouponDetailBloc extends Bloc<CouponDetailEvent, CouponDetailState> {
  final CouponDetailUseCase _couponDetailUseCase;

  CouponDetailBloc(this._couponDetailUseCase) : super(CouponDetailInitial()) {
    on<CouponDetailLoadInformation>(_onCouponDetailLoadInformation);
  }

  FutureOr<void> _onCouponDetailLoadInformation(
      CouponDetailLoadInformation event,
      Emitter<CouponDetailState> emit) async {
    try {
      emit(CouponDetailLoadInProcess());
      final coupon = await _couponDetailUseCase.getCouponDetail(event.couponId);
      await Future.delayed(Duration(seconds: 2));
      emit(CouponDetailLoadSuccess(coupon: coupon));
    } catch (e) {
      emit(CouponDetailLoadFailure());
    }
  }
}
