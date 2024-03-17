part of history;

class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  final HistoryUseCase _historyUseCase;

  HistoryBloc(this._historyUseCase) : super(HistoryInitial()) {
    on<HistoryLoadInformationInitialize>(_onHistoryLoadInformationInitialize);
    on<HistoryLoadInformationByStatus>(_onHistoryLoadInformationByStatus);
    on<HistoryLoadMoreInformationByStatus>(
        _onHistoryLoadMoreInformationByStatus);
  }

  FutureOr<void> _onHistoryLoadInformationInitialize(
      HistoryLoadInformationInitialize event,
      Emitter<HistoryState> emit) async {
    try {
      emit(HistoryLoadInProcess());
      final orderHistoryList = await _historyUseCase.getHistoryOrder(
          SharedService.getUserId()!,
          OrderHistoryParamsEntity(
              historyStatus: event.historyStatus,
              page: event.initPage,
              size: event.initSize));
      await Future.delayed(Duration(seconds: 2));
      final orderHistoryGroup = OrderHistoryGroupEntity(
        orderHistoryList: orderHistoryList,
        page: event.initPage,
        size: event.initSize,
      );
      switch (event.historyStatus) {
        case HistoryStatus.WAITING:
          emit(HistoryLoadSuccess(
              chosenStatus: event.historyStatus,
              orderWaitingGroup: orderHistoryGroup));
          break;
        case HistoryStatus.IN_PROCESS:
          emit(HistoryLoadSuccess(
              chosenStatus: event.historyStatus,
              orderProcessingGroup: orderHistoryGroup));
          break;
        case HistoryStatus.SUCCEED:
          emit(HistoryLoadSuccess(
              chosenStatus: event.historyStatus,
              orderSucceedGroup: orderHistoryGroup));
          break;
        case HistoryStatus.CANCELED:
          emit(HistoryLoadSuccess(
              chosenStatus: event.historyStatus,
              orderCanceledGroup: orderHistoryGroup));
          break;
      }
    } catch (e) {
      emit(HistoryLoadFailure());
      ExceptionUtil.handle(e);
    }
  }

  FutureOr<void> _onHistoryLoadInformationByStatus(
      HistoryLoadInformationByStatus event, Emitter<HistoryState> emit) async {
    try {
      if (state is HistoryLoadSuccess) {
        final currentState = state as HistoryLoadSuccess;
        //If type of history Loaded
        switch (event.historyStatus) {
          case HistoryStatus.WAITING:
            if(currentState.orderWaitingGroup != null) {
              emit(currentState.copyWith(
                  chosenStatus: event.historyStatus));
              return;
            }
          case HistoryStatus.IN_PROCESS:
            if(currentState.orderProcessingGroup != null) {
              emit(currentState.copyWith(
                  chosenStatus: event.historyStatus));
              return;
            }
          case HistoryStatus.SUCCEED:
            if(currentState.orderSucceedGroup != null) {
              emit(currentState.copyWith(
                  chosenStatus: event.historyStatus));
              return;
            }
          case HistoryStatus.CANCELED:
            if(currentState.orderCanceledGroup != null) {
              emit(currentState.copyWith(
                  chosenStatus: event.historyStatus));
              return;
            }
        }

        //If type of history Not Loaded Yet
        emit(HistoryLoadInProcess());
        final orderHistoryList = await _historyUseCase.getHistoryOrder(
            SharedService.getUserId()!,
            OrderHistoryParamsEntity(
                historyStatus: event.historyStatus,
                page: event.initPage,
                size: event.initSize));
        await Future.delayed(Duration(seconds: 2));
        final orderHistoryGroup = OrderHistoryGroupEntity(
          orderHistoryList: orderHistoryList,
          page: event.initPage,
          size: event.initSize,
        );
        switch (event.historyStatus) {
          case HistoryStatus.WAITING:
            emit(currentState.copyWith(
                chosenStatus: event.historyStatus,
                orderWaitingGroup: orderHistoryGroup));
            break;
          case HistoryStatus.IN_PROCESS:
            emit(currentState.copyWith(
                chosenStatus: event.historyStatus,
                orderProcessingGroup: orderHistoryGroup));
            break;
          case HistoryStatus.SUCCEED:
            emit(currentState.copyWith(
                chosenStatus: event.historyStatus,
                orderSucceedGroup: orderHistoryGroup));
            break;
          case HistoryStatus.CANCELED:
            emit(currentState.copyWith(
                chosenStatus: event.historyStatus,
                orderCanceledGroup: orderHistoryGroup));
            break;
        }
      }
    } catch (e) {
      emit(HistoryLoadFailure());
      ExceptionUtil.handle(e);
    }
  }

  FutureOr<void> _onHistoryLoadMoreInformationByStatus(
      HistoryLoadMoreInformationByStatus event,
      Emitter<HistoryState> emit) async {
    try {
      if (state is HistoryLoadSuccess) {
        final currentState = state as HistoryLoadSuccess;
        switch (currentState.chosenStatus) {
          case HistoryStatus.WAITING:
            final orderGroup = currentState.orderWaitingGroup;
            emit(currentState.copyWith(
                orderWaitingGroup: orderGroup?.copyWith(isLoadMore: true)));

            final orderHistoryList = await _historyUseCase.getHistoryOrder(
                SharedService.getUserId()!,
                OrderHistoryParamsEntity(
                    historyStatus: currentState.chosenStatus,
                    page: orderGroup!.page! + 1,
                    size: orderGroup.size!));

            if (orderHistoryList.isNotEmpty) {
              emit(currentState.copyWith(
                  orderWaitingGroup: orderGroup.copyWith(
                      orderHistoryList: List.from(orderGroup.orderHistoryList!)
                        ..addAll(orderHistoryList),
                      page: orderGroup.page! + 1,
                      isLoadMore: false)));
            } else {
              emit(currentState.copyWith(
                  orderWaitingGroup:
                      orderGroup.copyWith(cannotLoadMore: true)));
            }
            break;

          case HistoryStatus.IN_PROCESS:
            final orderGroup = currentState.orderProcessingGroup;
            emit(currentState.copyWith(
                orderProcessingGroup: orderGroup?.copyWith(isLoadMore: true)));

            final orderHistoryList = await _historyUseCase.getHistoryOrder(
                SharedService.getUserId()!,
                OrderHistoryParamsEntity(
                    historyStatus: currentState.chosenStatus,
                    page: orderGroup!.page! + 1,
                    size: orderGroup.size!));

            if (orderHistoryList.isNotEmpty) {
              emit(currentState.copyWith(
                  orderProcessingGroup: orderGroup.copyWith(
                      orderHistoryList: List.from(orderGroup.orderHistoryList!)
                        ..addAll(orderHistoryList),
                      page: orderGroup.page! + 1,
                      isLoadMore: false)));
            } else {
              emit(currentState.copyWith(
                  orderProcessingGroup:
                      orderGroup.copyWith(cannotLoadMore: true)));
            }
            break;
          case HistoryStatus.SUCCEED:
            final orderGroup = currentState.orderSucceedGroup;
            emit(currentState.copyWith(
                orderSucceedGroup: orderGroup?.copyWith(isLoadMore: true)));

            final orderHistoryList = await _historyUseCase.getHistoryOrder(
                SharedService.getUserId()!,
                OrderHistoryParamsEntity(
                    historyStatus: currentState.chosenStatus,
                    page: orderGroup!.page! + 1,
                    size: orderGroup.size!));

            if (orderHistoryList.isNotEmpty) {
              emit(currentState.copyWith(
                  orderSucceedGroup: orderGroup.copyWith(
                      orderHistoryList: List.from(orderGroup.orderHistoryList!)
                        ..addAll(orderHistoryList),
                      page: orderGroup.page! + 1,
                      isLoadMore: false)));
            } else {
              emit(currentState.copyWith(
                  orderSucceedGroup:
                      orderGroup.copyWith(cannotLoadMore: true)));
            }
            break;
          case HistoryStatus.CANCELED:
            final orderGroup = currentState.orderCanceledGroup;
            emit(currentState.copyWith(
                orderCanceledGroup: orderGroup?.copyWith(isLoadMore: true)));

            final orderHistoryList = await _historyUseCase.getHistoryOrder(
                SharedService.getUserId()!,
                OrderHistoryParamsEntity(
                    historyStatus: currentState.chosenStatus,
                    page: orderGroup!.page! + 1,
                    size: orderGroup.size!));

            if (orderHistoryList.isNotEmpty) {
              emit(currentState.copyWith(
                  orderCanceledGroup: orderGroup.copyWith(
                      orderHistoryList: List.from(orderGroup.orderHistoryList!)
                        ..addAll(orderHistoryList),
                      page: orderGroup.page! + 1,
                      isLoadMore: false)));
            } else {
              emit(currentState.copyWith(
                  orderCanceledGroup:
                      orderGroup.copyWith(cannotLoadMore: true)));
            }
            break;
        }
      }
    } catch (e) {
      emit(HistoryLoadFailure());
      ExceptionUtil.handle(e);
    }
  }
}
