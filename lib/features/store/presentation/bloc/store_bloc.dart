part of store;

class StoreBloc extends Bloc<StoreEvent, StoreState> {
  final StoreUseCase _storeUseCase;

  StoreBloc(this._storeUseCase) : super(StoreInitial()) {
    on<StoreLoadInformation>(_onStoreLoadInformation);
    on<StoreLoadMoreInformation>(_onStoreLoadMoreInformation);
  }

  FutureOr<void> _onStoreLoadInformation(
      StoreLoadInformation event, Emitter<StoreState> emit) async {
    try {
      emit(StoreLoadInProcess());
      double latitude;
      double longitude;
      if (await PermissionUtil.requestLocationPermission() == true) {
        Position currentPosition = await _storeUseCase.getCurrentPosition();

        emit(StoreEnableLocationPermission(
            lat: currentPosition.latitude, lng: currentPosition.longitude));
        latitude = currentPosition.latitude;
        longitude = currentPosition.longitude;
      } else {
        emit(StoreNoLocationPermission());
        return;
      }
      final stores = await _storeUseCase.getAllStores(StoreAllParamsEntity(
          lat: latitude, lng: longitude, page: event.page, size: event.size));
      if (stores != null) {
        emit(StoreLoadSuccess(stores: stores));
      } else {
        emit(StoreLoadFailure());
      }
    } catch (e) {
      emit(StoreLoadFailure());
      ExceptionUtil.handle(e);
    }
  }

  FutureOr<void> _onStoreLoadMoreInformation(
      StoreLoadMoreInformation event, Emitter<StoreState> emit) async {
    try {
      if (event.lat == null || event.lng == null) {
        emit(StoreNoLocationPermission());
      }
      final currentState = state as StoreLoadSuccess;
      emit(currentState.copyWith(isLoadMore: true));
      final stores = await _storeUseCase.getAllStores(StoreAllParamsEntity(
          lat: event.lat!,
          lng: event.lng!,
          page: event.page,
          size: event.size));
      await Future.delayed(Duration(milliseconds: 1000));
      if (stores!.isNotEmpty) {
        emit(currentState.copyWith(
            stores: List.from(currentState.stores)..addAll(stores),
            isLoadMore: false));
      } else {
        emit(currentState.copyWith(cannotLoadMore: true));
      }
    } catch (e) {
      emit(StoreLoadFailure());
      ExceptionUtil.handle(e);
    }
  }
}
