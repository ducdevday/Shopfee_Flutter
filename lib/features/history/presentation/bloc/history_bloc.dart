part of history;

class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  final HistoryUseCase _historyUseCase;

  HistoryBloc(this._historyUseCase) : super(HistoryInitial()) {
    on<LoadHistory>(_onLoadHistory);
    on<LoadMoreHistory>(_onLoadMoreHistory);
  }

  FutureOr<void> _onLoadHistory(
      LoadHistory event, Emitter<HistoryState> emit) async {
    try {
      emit(HistoryLoading());
      if (SharedService.getUserId() == null) {
        emit(HistoryNotAuth());
        return;
      }
      List<OrderHistoryEntity> orderHistoryList = [];
      int page = 1;
      int size = 8;
      await Future.delayed(Duration(milliseconds: 500));

      switch (event.historyStatus) {
        case HistoryStatus.Processing:
          final response = await Future.wait([
            _historyUseCase.getHistoryOrder(
                SharedService.getUserId()!, OrderStatus.CREATED,
                page: page, size: size),
            _historyUseCase.getHistoryOrder(
                SharedService.getUserId()!, OrderStatus.ACCEPTED,
                page: page, size: size),
            _historyUseCase.getHistoryOrder(
                SharedService.getUserId()!, OrderStatus.DELIVERING,
                page: page, size: size)
          ]);
          final List<OrderHistoryEntity> orderHistoryCreatedList = response[0];
          final List<OrderHistoryEntity> orderHistoryAcceptedList = response[1];
          final List<OrderHistoryEntity> orderHistoryDeliveringList =
              response[2];
          orderHistoryList.addAll(orderHistoryCreatedList);
          orderHistoryList.addAll(orderHistoryAcceptedList);
          orderHistoryList.addAll(orderHistoryDeliveringList);
          break;

        case HistoryStatus.Done:
          final List<OrderHistoryEntity> orderHistoryDoneList =
              await _historyUseCase.getHistoryOrder(
                  SharedService.getUserId()!, OrderStatus.SUCCEED,
                  page: page, size: size);
          orderHistoryList.addAll(orderHistoryDoneList);
          break;

        case HistoryStatus.Canceled:
          final List<OrderHistoryEntity> orderHistoryCanceledList =
              await _historyUseCase.getHistoryOrder(
                  SharedService.getUserId()!, OrderStatus.CANCELED,
                  page: page, size: size);
          orderHistoryList.addAll(orderHistoryCanceledList);
          break;
      }
      emit(HistoryLoaded(
          historyStatus: event.historyStatus,
          orderHistoryList: orderHistoryList,
          page: page,
          size: size));
    } catch (e) {
      emit(HistoryError());
      ExceptionUtil.handle(e);
    }
  }

  FutureOr<void> _onLoadMoreHistory(
      LoadMoreHistory event, Emitter<HistoryState> emit) async {
    List<OrderHistoryEntity> orderMoreHistoryList = [];
    try{
      if (state is HistoryLoaded) {
        final currentState = state as HistoryLoaded;
        emit(currentState.copyWith(isLoadMore: true));
        await Future.delayed(Duration(milliseconds: 1000));
        switch (event.historyStatus) {
          case HistoryStatus.Processing:
            final response = await Future.wait([
              _historyUseCase.getHistoryOrder(
                  SharedService.getUserId()!, OrderStatus.CREATED,
                  page: currentState.page + 1, size: currentState.size),
              _historyUseCase.getHistoryOrder(
                  SharedService.getUserId()!, OrderStatus.ACCEPTED,
                  page: currentState.page + 1, size: currentState.size),
              _historyUseCase.getHistoryOrder(
                  SharedService.getUserId()!, OrderStatus.DELIVERING,
                  page: currentState.page + 1, size: currentState.size)
            ]);
            final List<OrderHistoryEntity> orderHistoryCreatedList = response[0];
            final List<OrderHistoryEntity> orderHistoryAcceptedList = response[1];
            final List<OrderHistoryEntity> orderHistoryDeliveringList =
            response[2];
            orderMoreHistoryList.addAll(orderHistoryCreatedList);
            orderMoreHistoryList.addAll(orderHistoryAcceptedList);
            orderMoreHistoryList.addAll(orderHistoryDeliveringList);
            break;

          case HistoryStatus.Done:
            final List<OrderHistoryEntity> orderHistoryDoneList =
            await _historyUseCase.getHistoryOrder(
                SharedService.getUserId()!, OrderStatus.SUCCEED,
                page: currentState.page + 1, size: currentState.size);
            orderMoreHistoryList.addAll(orderHistoryDoneList);
            break;

          case HistoryStatus.Canceled:
            final List<OrderHistoryEntity> orderHistoryCanceledList =
            await _historyUseCase.getHistoryOrder(
                SharedService.getUserId()!, OrderStatus.CANCELED,
                page: currentState.page + 1, size: currentState.size);
            orderMoreHistoryList.addAll(orderHistoryCanceledList);
            break;
        }
        if (orderMoreHistoryList.isNotEmpty) {
          emit(currentState.copyWith(
              orderHistoryList: List.from(currentState.orderHistoryList)
                ..addAll(orderMoreHistoryList),
              page: currentState.page + 1,
              isLoadMore: false));
        } else {
          emit(currentState.copyWith(cannotLoadMore: true));
        }
      }
    }
    catch(e){
      emit(HistoryError());
      ExceptionUtil.handle(e);
    }
  }
}
