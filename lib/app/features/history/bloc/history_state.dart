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

  const HistoryLoaded({
    this.historyStatus = HistoryStatus.Processing,
    this.orderHistoryList = const [],
  });

  @override
  List<Object> get props => [historyStatus, orderHistoryList];

  HistoryLoaded copyWith({
    HistoryStatus? historyStatus,
    List<OrderHistory>? orderHistoryList,
  }) {
    return HistoryLoaded(
      historyStatus: historyStatus ?? this.historyStatus,
      orderHistoryList: orderHistoryList ?? this.orderHistoryList,
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