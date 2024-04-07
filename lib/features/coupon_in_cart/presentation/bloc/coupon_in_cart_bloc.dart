part of coupon_in_cart;

class CouponInCartBloc extends Bloc<CouponInCartEvent, CouponInCartState> {
  final CouponInCartUseCase _couponInCartUseCase;

  CouponInCartBloc(this._couponInCartUseCase) : super(CouponInCartInitial()) {
    on<CouponInCartLoadInitInformation>(_onCouponInCartLoadInitInformation);
    on<CouponInCartChooseItem>(_onCouponInCartChooseItem);
    on<CouponInCartLoadChosenInformation>(_onCouponInCartLoadChosenInformation);
    on<CouponInCartRefreshInformation>(_onCouponInCartRefreshInformation);
  }

  FutureOr<void> _onCouponInCartLoadInitInformation(
      CouponInCartLoadInitInformation event,
      Emitter<CouponInCartState> emit) async {
    try {
      emit(CouponInCartLoadInProcess());
      final result = await _couponInCartUseCase.getCouponListInCart(
          event.cart,
          event.shippingCouponChosenCode,
          event.orderCouponChosenCode,
          event.productCouponChosenCode);
      emit(CouponInCartLoadSuccess(
        couponInCart: result,
        currentCart: event.cart,
        shippingCouponChosenCode: event.shippingCouponChosenCode,
        orderCouponChosenCode: event.orderCouponChosenCode,
        productCouponChosenCode: event.productCouponChosenCode,
      ));
    } catch (e) {
      emit(CouponInCartLoadFailure());
    }
  }

  FutureOr<void> _onCouponInCartChooseItem(
      CouponInCartChooseItem event, Emitter<CouponInCartState> emit) {
    try {
      if (state is CouponInCartLoadSuccess) {
        final currentState = state as CouponInCartLoadSuccess;
        if (event.couponType == CouponType.SHIPPING) {
          emit(currentState.copyWith(
              shippingCouponChosenCode: () => event.couponCode));
        } else if (event.couponType == CouponType.ORDER) {
          emit(currentState.copyWith(
              orderCouponChosenCode: () => event.couponCode));
        } else if (event.couponType == CouponType.PRODUCT) {
          emit(currentState.copyWith(
              productCouponChosenCode: () => event.couponCode));
        }
        add(CouponInCartLoadChosenInformation());
      }
    } catch (e) {
      ExceptionUtil.handle(e);
    }
  }

  FutureOr<void> _onCouponInCartLoadChosenInformation(
      CouponInCartLoadChosenInformation event,
      Emitter<CouponInCartState> emit) async {
    try {
      if (state is CouponInCartLoadSuccess) {
        final currentState = state as CouponInCartLoadSuccess;
        EasyLoading.show();
        final result = await _couponInCartUseCase.getCouponListInCart(
            currentState.currentCart,
            currentState.shippingCouponChosenCode,
            currentState.orderCouponChosenCode,
            currentState.productCouponChosenCode);
        EasyLoading.dismiss();
        emit(currentState.copyWith(
          couponInCart: result,
          currentCart: currentState.currentCart,
        ));
      }
    } catch (e) {
      emit(CouponInCartLoadFailure());
    }
  }

  FutureOr<void> _onCouponInCartRefreshInformation(CouponInCartRefreshInformation event, Emitter<CouponInCartState> emit) async{
    try {
      if (state is CouponInCartLoadSuccess) {
        final currentState = state as CouponInCartLoadSuccess;
        final result = await _couponInCartUseCase.getCouponListInCart(
            currentState.currentCart,
            currentState.shippingCouponChosenCode,
            currentState.orderCouponChosenCode,
            currentState.productCouponChosenCode);
        emit(currentState.copyWith(
          couponInCart: result,
          currentCart: currentState.currentCart,
        ));
      }
    } catch (e) {
      emit(CouponInCartLoadFailure());
    }
  }
}
