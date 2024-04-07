part of history;

class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  final HistoryUseCase _historyUseCase;

  HistoryBloc(this._historyUseCase) : super(HistoryInitial()) {
    on<HistoryLoadInformation>(_onHistoryLoadInformation);
    on<HistoryLoadMoreInformation>(_onHistoryLoadMoreInformation);
    on<HistoryRefreshInformation>(_onHistoryRefreshInformation);
  }

  FutureOr<void> _onHistoryLoadInformation(
      HistoryLoadInformation event, Emitter<HistoryState> emit) async {
    try {
      emit(HistoryLoadInProcess());
      final orderHistoryList = await _historyUseCase.getHistoryOrder(
          SharedService.getUserId()!,
          OrderHistoryParamsEntity(
              historyStatus: event.historyStatus,
              page: event.initPage,
              size: event.initSize));
      await Future.delayed(Duration(seconds: 2));
      emit(HistoryLoadSuccess(
          historyStatus: event.historyStatus,
          orderHistoryList: orderHistoryList,
          page: event.initSize,
          size: event.initSize));
    } catch (e) {
      emit(HistoryLoadFailure());
      ExceptionUtil.handle(e);
    }
  }

  FutureOr<void> _onHistoryRefreshInformation(
      HistoryRefreshInformation event, Emitter<HistoryState> emit) async {
    try {
      if (state is HistoryLoadSuccess) {
        final currentState = state as HistoryLoadSuccess;
        final orderHistoryList = await _historyUseCase.getHistoryOrder(
            SharedService.getUserId()!,
            OrderHistoryParamsEntity(
                historyStatus: currentState.historyStatus,
                page: event.initPage,
                size: event.initSize));
        await Future.delayed(Duration(seconds: 2));
        emit(HistoryLoadSuccess(
            historyStatus: currentState.historyStatus,
            orderHistoryList: orderHistoryList,
            page: event.initSize,
            size: event.initSize));
      }
    } catch (e) {
      emit(HistoryLoadFailure());
      ExceptionUtil.handle(e);
    }
  }

  FutureOr<void> _onHistoryLoadMoreInformation(
      HistoryLoadMoreInformation event, Emitter<HistoryState> emit) async {
    try {
      if (state is HistoryLoadSuccess) {
        final currentState = state as HistoryLoadSuccess;
        emit(currentState.copyWith(isLoadMore: true));

        final orderHistoryList = await _historyUseCase.getHistoryOrder(
            SharedService.getUserId()!,
            OrderHistoryParamsEntity(
                historyStatus: currentState.historyStatus,
                page: currentState.page + 1,
                size: currentState.size));

        if (orderHistoryList.isNotEmpty) {
          emit(currentState.copyWith(
              orderHistoryList: List.from(currentState.orderHistoryList)
                ..addAll(orderHistoryList),
              page: currentState.page + 1,
              isLoadMore: false));
        } else {
          emit(currentState.copyWith(cannotLoadMore: true));
        }
      }
    } catch (e) {
      emit(HistoryLoadFailure());
      ExceptionUtil.handle(e);
    }
  }
}
