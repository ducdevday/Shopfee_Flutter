part of coin;

class CoinBloc extends Bloc<CoinEvent, CoinState> {
  final CoinUseCase _coinUseCase;

  CoinBloc(this._coinUseCase) : super(CoinInitial()) {
    on<CoinLoadInformation>(_onCoinLoadInformation);
    on<CoinLoadMoreInformation>(_onCoinLoadMoreInformation);
    on<CoinRefreshInformation>(_onCoinRefreshInformation);
  }

  FutureOr<void> _onCoinLoadInformation(
      CoinLoadInformation event, Emitter<CoinState> emit) async {
    try {
      emit(CoinLoadInProcess());
      final params =
          CoinHistoryParams(page: event.initPage, size: event.initSize);
      final coinHistoryList =
          await _coinUseCase.getCoinHistory(event.userId, params);
      await Future.delayed(Duration(seconds: 1));
      emit(CoinLoadSuccess(
          coinHistoryList: coinHistoryList,
          page: event.initPage,
          size: event.initSize));
    } catch (e) {
      emit(CoinLoadFailure());
    }
  }

  FutureOr<void> _onCoinLoadMoreInformation(
      CoinLoadMoreInformation event, Emitter<CoinState> emit) async {
    try {
      if (state is CoinLoadSuccess) {
        final currentState = state as CoinLoadSuccess;
        emit(currentState.copyWith(isLoadMore: true));
        final params = CoinHistoryParams(
            page: currentState.page + 1, size: currentState.size);
        final orderHistoryList =
            await _coinUseCase.getCoinHistory(event.userId, params);

        if (orderHistoryList.isNotEmpty) {
          emit(currentState.copyWith(
              coinHistoryList: List.from(currentState.coinHistoryList)
                ..addAll(orderHistoryList),
              page: currentState.page + 1,
              isLoadMore: false));
        } else {
          emit(currentState.copyWith(cannotLoadMore: true));
        }
      }
    } catch (e) {
      ExceptionUtil.handle(e);
    }
  }

  FutureOr<void> _onCoinRefreshInformation(
      CoinRefreshInformation event, Emitter<CoinState> emit) async {
    try {
      try {
        final params =
            CoinHistoryParams(page: event.initPage, size: event.initSize);
        final coinHistoryList =
            await _coinUseCase.getCoinHistory(event.userId, params);
        await Future.delayed(Duration(seconds: 1));
        emit(CoinLoadSuccess(
            coinHistoryList: coinHistoryList,
            page: event.initPage,
            size: event.initSize));
      } catch (e) {
        ExceptionUtil.handle(e);
      }
    } catch (e) {
      ExceptionUtil.handle(e);
    }
  }
}
