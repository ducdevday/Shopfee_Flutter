part of history;

abstract class HistoryState extends Equatable {
  const HistoryState();
}

class HistoryInitial extends HistoryState {
  @override
  List<Object> get props => [];
}

class HistoryLoadInProcess extends HistoryState {
  @override
  List<Object> get props => [];
}

class HistoryLoadSuccess extends HistoryState {
  final HistoryStatus chosenStatus;
  final OrderHistoryGroupEntity? orderWaitingGroup;
  final OrderHistoryGroupEntity? orderProcessingGroup;
  final OrderHistoryGroupEntity? orderSucceedGroup;
  final OrderHistoryGroupEntity? orderCanceledGroup;

  const HistoryLoadSuccess({
    required this.chosenStatus,
    this.orderWaitingGroup,
    this.orderProcessingGroup,
    this.orderSucceedGroup,
    this.orderCanceledGroup,
  });

  OrderHistoryGroupEntity? get orderHistoryGroup {
    switch(chosenStatus){
      case HistoryStatus.WAITING:
        return orderWaitingGroup;
      case HistoryStatus.IN_PROCESS:
        return orderProcessingGroup;
      case HistoryStatus.SUCCEED:
        return orderSucceedGroup;
      case HistoryStatus.CANCELED:
        return orderCanceledGroup;
    }
  }


  HistoryLoadSuccess copyWith({
    HistoryStatus? chosenStatus,
    OrderHistoryGroupEntity? orderWaitingGroup,
    OrderHistoryGroupEntity? orderProcessingGroup,
    OrderHistoryGroupEntity? orderSucceedGroup,
    OrderHistoryGroupEntity? orderCanceledGroup,
  }) {
    return HistoryLoadSuccess(
      chosenStatus: chosenStatus ?? this.chosenStatus,
      orderWaitingGroup: orderWaitingGroup ?? this.orderWaitingGroup,
      orderProcessingGroup: orderProcessingGroup ?? this.orderProcessingGroup,
      orderSucceedGroup: orderSucceedGroup ?? this.orderSucceedGroup,
      orderCanceledGroup: orderCanceledGroup ?? this.orderCanceledGroup,
    );
  }

  @override
  List<Object?> get props =>
      [
        chosenStatus,
        orderWaitingGroup,
        orderProcessingGroup,
        orderSucceedGroup,
        orderCanceledGroup,
      ];
}

class HistoryNotAuth extends HistoryState {
  @override
  List<Object> get props => [];
}

class HistoryLoadFailure extends HistoryState {
  @override
  List<Object> get props => [];
}
