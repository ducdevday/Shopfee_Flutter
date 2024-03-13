part of store_detail;

class StoreDetailBloc extends Bloc<StoreDetailEvent, StoreDetailState> {
  final StoreDetailUseCase _storeDetailUseCase;

  StoreDetailBloc(this._storeDetailUseCase) : super(StoreDetailInitial()) {
    on<StoreDetailLoadInformation>(_onStoreDetailLoadInformation);
  }

  FutureOr<void> _onStoreDetailLoadInformation(
      StoreDetailLoadInformation event, Emitter<StoreDetailState> emit) async {
    try {
      emit(StoreDetailLoadInProcess());
      final store = await _storeDetailUseCase.getDetailStore(event.branchId!);
      await Future.delayed(Duration(milliseconds: 1500));
      emit(StoreDetailLoadSuccess(store: store));
    } catch (e) {
      emit(StoreDetailLoadFailure());
      ExceptionUtil.handle(e);
    }
  }
}
