part of coupon_in_cart;

class CouponInCartBloc extends Bloc<CouponInCartEvent, CouponInCartState> {
  final CouponInCartUseCase _couponInCartUseCase;

  CouponInCartBloc(this._couponInCartUseCase) : super(CouponInCartInitial()) {
    on<CouponInCartLoadInformation>(_onCouponInCartLoadInformation);
  }

  FutureOr<void> _onCouponInCartLoadInformation(
      CouponInCartLoadInformation event,
      Emitter<CouponInCartState> emit) async {
    try {
      emit(CouponInCartLoadInProcess());
      final result = await _couponInCartUseCase.getCouponListInCart(event.cart);
      emit(CouponInCartLoadSuccess(couponInCart: result));
    } catch (e) {
      emit(CouponInCartLoadFailure());
    }
  }
}
