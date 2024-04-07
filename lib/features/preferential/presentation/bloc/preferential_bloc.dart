part of preferential;

class PreferentialBloc extends Bloc<PreferentialEvent, PreferentialState> {
  final PreferentialUseCase _preferentialUseCase;

  PreferentialBloc(this._preferentialUseCase) : super(PreferentialInitial()) {
    on<PreferentialLoadTopCoupon>(_onPreferentialLoadTopCoupon);
    on<PreferentialRefreshTopCoupon>(_onPreferentialRefreshTopCoupon);
  }

  FutureOr<void> _onPreferentialLoadTopCoupon(
      PreferentialLoadTopCoupon event, Emitter<PreferentialState> emit) async {
    try {
      emit(PreferentialLoadInProcess());
      final coupons =
          await _preferentialUseCase.getTopCoupons(event.quantityTop);
      await Future.delayed(Duration(seconds: 1));
      emit(PreferentialLoadSuccess(coupons: coupons));
    } catch (e) {
      emit(PreferentialLoadFailure());
    }
  }

  FutureOr<void> _onPreferentialRefreshTopCoupon(
      PreferentialRefreshTopCoupon event,
      Emitter<PreferentialState> emit) async {
    try {
      final coupons =
          await _preferentialUseCase.getTopCoupons(event.quantityTop);
      emit(PreferentialLoadSuccess(coupons: coupons));
    } catch (e) {
      emit(PreferentialLoadFailure());
    }
  }
}
