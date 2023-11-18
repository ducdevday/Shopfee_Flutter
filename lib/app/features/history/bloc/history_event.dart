part of 'history_bloc.dart';

abstract class HistoryEvent extends Equatable {
  const HistoryEvent();
}


class LoadHistory extends HistoryEvent {
  final HistoryStatus historyStatus;

  const LoadHistory({
    required this.historyStatus,
  });

  @override
  List<Object> get props => [historyStatus];
}

class LoadMoreHistory extends HistoryEvent {
  final HistoryStatus historyStatus;

  const LoadMoreHistory({
    required this.historyStatus,
  });

  @override
  List<Object> get props => [historyStatus];
}
