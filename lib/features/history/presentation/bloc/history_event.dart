part of history;

abstract class HistoryEvent extends Equatable {
  const HistoryEvent();
}

class HistoryLoadInformation extends HistoryEvent {
  final HistoryStatus historyStatus;
  final int initPage;
  final int initSize;

  const HistoryLoadInformation({
    required this.historyStatus,
    required this.initPage,
    required this.initSize,
  });

  @override
  List<Object> get props => [historyStatus, initPage, initSize];
}

class HistoryLoadMoreInformation extends HistoryEvent {
  const HistoryLoadMoreInformation();

  @override
  List<Object> get props => [];
}

class HistoryRefreshInformation extends HistoryEvent {
  final int initPage;
  final int initSize;

  const HistoryRefreshInformation({
    required this.initPage,
    required this.initSize,
  });

  @override
  List<Object> get props => [initPage, initSize];
}
