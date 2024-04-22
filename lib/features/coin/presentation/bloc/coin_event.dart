part of coin;

sealed class CoinEvent extends Equatable {
  const CoinEvent();
}

class CoinLoadInformation extends CoinEvent {
  final String userId;
  final int initPage;
  final int initSize;

  const CoinLoadInformation({
    required this.userId,
    required this.initPage,
    required this.initSize,
  });

  @override
  List<Object> get props => [userId, initPage, initSize];
}

class CoinLoadMoreInformation extends CoinEvent {
  final String userId;

  const CoinLoadMoreInformation({
    required this.userId,
  });

  @override
  List<Object> get props => [userId];
}

class CoinRefreshInformation extends CoinEvent {
  final String userId;
  final int initPage;
  final int initSize;

  const CoinRefreshInformation({
    required this.userId,
    required this.initPage,
    required this.initSize,
  });

  @override
  List<Object> get props => [userId, initPage, initSize];
}
