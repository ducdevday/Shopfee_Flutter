part of 'history_bloc.dart';

abstract class HistoryState extends Equatable {
  const HistoryState();
}

class HistoryInitial extends HistoryState {
  @override
  List<Object> get props => [];
}

class HistoryLoading extends HistoryState {
  @override
  List<Object> get props => [];
}

class HistoryLoaded extends HistoryState {
  final HistoryStatus historyStatus;
  final List<OrderHistory> orderHistoryList;
  final int page;
  final int size;
  final bool isLoadMore;
  final bool cannotLoadMore;

  const HistoryLoaded(
      {this.historyStatus = HistoryStatus.Processing,
      this.orderHistoryList = const [],
      required this.page,
      required this.size,
      this.isLoadMore = false,
      this.cannotLoadMore = false});

  @override
  List<Object> get props => [
        historyStatus,
        orderHistoryList,
        page,
        size,
        isLoadMore,
        cannotLoadMore,
      ];

  HistoryLoaded copyWith({
    HistoryStatus? historyStatus,
    List<OrderHistory>? orderHistoryList,
    int? page,
    int? size,
    bool? isLoadMore,
    bool? cannotLoadMore,
  }) {
    return HistoryLoaded(
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

class HistoryError extends HistoryState {
  @override
  List<Object> get props => [];
}
