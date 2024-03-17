part of history;

abstract class HistoryEvent extends Equatable {
  const HistoryEvent();
}

class HistoryLoadInformationInitialize extends HistoryEvent {
  final HistoryStatus historyStatus;
  final int initPage;
  final int initSize;

  const HistoryLoadInformationInitialize({
    required this.historyStatus,
    required this.initPage,
    required this.initSize,
  });

  @override
  List<Object> get props => [historyStatus, initPage, initSize];
}

class HistoryLoadInformationByStatus extends HistoryEvent {
  final HistoryStatus historyStatus;
  final int initPage;
  final int initSize;

  const HistoryLoadInformationByStatus({
    required this.historyStatus,
    required this.initPage,
    required this.initSize,
  });

  @override
  List<Object> get props => [historyStatus, initPage, initSize];
}

class HistoryLoadMoreInformationByStatus extends HistoryEvent {
  const HistoryLoadMoreInformationByStatus();

  @override
  List<Object> get props => [];
}
