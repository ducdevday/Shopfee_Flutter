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
  final HistoryStatus historyStatus;
  final List<OrderHistoryEntity> orderHistoryList;
  final int page;
  final int size;
  final bool isLoadMore;
  final bool cannotLoadMore;

  const HistoryLoadSuccess({
    required this.historyStatus,
    required this.orderHistoryList,
    required this.page,
    required this.size,
    this.isLoadMore = false,
    this.cannotLoadMore = false,
  });

  @override
  List<Object?> get props => [
        historyStatus,
        orderHistoryList,
        page,
        size,
        isLoadMore,
        cannotLoadMore,
      ];

  HistoryLoadSuccess copyWith({
    HistoryStatus? historyStatus,
    List<OrderHistoryEntity>? orderHistoryList,
    int? page,
    int? size,
    bool? isLoadMore,
    bool? cannotLoadMore,
  }) {
    return HistoryLoadSuccess(
      historyStatus: historyStatus ?? this.historyStatus,
      orderHistoryList: orderHistoryList ?? this.orderHistoryList,
      page: page ?? this.page,
      size: size ?? this.size,
      isLoadMore: isLoadMore ?? this.isLoadMore,
      cannotLoadMore: cannotLoadMore ?? this.cannotLoadMore,
    );
  }
}

class HistoryNotAuth extends HistoryState {
  @override
  List<Object> get props => [];
}

class HistoryLoadFailure extends HistoryState {
  @override
  List<Object> get props => [];
}
