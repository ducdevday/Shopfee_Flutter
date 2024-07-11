part of store;

class StoreBloc extends Bloc<StoreEvent, StoreState> {
  final StoreUseCase _storeUseCase;

  StoreBloc(this._storeUseCase) : super(StoreInitial()) {
    on<StoreLoadInformation>(_onStoreLoadInformation);
    on<StoreLoadMoreInformation>(_onStoreLoadMoreInformation);
    on<StoreRefreshInformation>(_onStoreRefreshInformation);
    on<StoreChangeViewType>(_onStoreChangeViewType);
  }

  FutureOr<void> _onStoreLoadInformation(
      StoreLoadInformation event, Emitter<StoreState> emit) async {
    try {
      emit(StoreLoadInProcess());
      if (await PermissionUtil.requestLocationPermission() == false) {
        emit(StoreNoLocationPermission());
        return;
      }
      Position currentPosition = await GlobalData.ins.getCurrentPosition();
      final stores = await _storeUseCase.getAllStores(StoreAllParamsEntity(
        key: event.query,
        all: event.getAll,
        lat: currentPosition.latitude,
        lng: currentPosition.longitude,
        page: event.initPage,
        size: event.initSize,
      ));
      if (stores != null) {
        emit(StoreLoadSuccess(
            page: event.initPage,
            size: event.initSize,
            query: event.query,
            getAll: event.getAll,
            stores: stores,
            currentPosition: currentPosition));
      } else {
        emit(StoreLoadFailure());
      }
    } catch (e) {
      emit(StoreLoadFailure());
    }
  }

  FutureOr<void> _onStoreLoadMoreInformation(
      StoreLoadMoreInformation event, Emitter<StoreState> emit) async {
    try {
      if (state is StoreLoadSuccess) {
        final currentState = state as StoreLoadSuccess;
        emit(currentState.copyWith(isLoadMore: true));
        final stores = await _storeUseCase.getAllStores(StoreAllParamsEntity(
            key: currentState.query,
            all: currentState.getAll,
            lat: currentState.currentPosition!.latitude,
            lng: currentState.currentPosition!.longitude,
            page: currentState.page + 1,
            size: currentState.size));
        await Future.delayed(Duration(milliseconds: 1000));
        if (stores!.isNotEmpty) {
          emit(currentState.copyWith(
              stores: List.from(currentState.stores)..addAll(stores),
              page: currentState.page + 1,
              isLoadMore: false));
        } else {
          emit(currentState.copyWith(cannotLoadMore: true));
        }
      }
    } catch (e) {
      emit(StoreLoadFailure());
      ExceptionUtil.handle(e);
    }
  }

  FutureOr<void> _onStoreRefreshInformation(
      StoreRefreshInformation event, Emitter<StoreState> emit) async {
    try {
      if (state is StoreLoadSuccess) {
        final currentState = state as StoreLoadSuccess;
        final stores = await _storeUseCase.getAllStores(StoreAllParamsEntity(
          key: currentState.query,
          all: currentState.getAll,
          lat: currentState.currentPosition!.latitude,
          lng: currentState.currentPosition!.longitude,
          page: 1,
          size: currentState.size,
        ));
        if (stores != null) {
          emit(StoreLoadSuccess(
              page: 1,
              size: currentState.size,
              query: currentState.query,
              getAll: currentState.getAll,
              stores: stores,
              currentPosition: currentState.currentPosition));
        } else {
          emit(StoreLoadFailure());
        }
      }
    } catch (e) {
      emit(StoreLoadFailure());
    }
  }

  FutureOr<void> _onStoreChangeViewType(
      StoreChangeViewType event, Emitter<StoreState> emit) async {
    try {
      if (state is StoreLoadSuccess) {
        final currentState = state as StoreLoadSuccess;
        emit(currentState.copyWith(viewType: event.viewType));
        if (event.viewType == StoreViewType.Map_View &&
            currentState.stores.isEmpty) {
          final stores = await _storeUseCase.getAllStores(StoreAllParamsEntity(
              key: currentState.query,
              all: currentState.getAll,
              lat: currentState.currentPosition!.latitude,
              lng: currentState.currentPosition!.longitude,
              page: 1,
              size: 1000));
          if (stores!.isNotEmpty) {
            emit(currentState.copyWith(
              stores: List.from(currentState.stores)..addAll(stores),
              isLoadMore: false,
              cannotLoadMore: true,
            ));
          }
        }
      }
    } catch (e) {
      emit(StoreLoadFailure());
      ExceptionUtil.handle(e);
    }
  }
}
