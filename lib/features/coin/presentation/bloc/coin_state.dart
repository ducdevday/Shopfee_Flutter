part of coin;

sealed class CoinState extends Equatable {
  const CoinState();
}

final class CoinInitial extends CoinState {
  @override
  List<Object> get props => [];
}

final class CoinLoadInProcess extends CoinState {
  @override
  List<Object> get props => [];
}

final class CoinLoadSuccess extends CoinState {
  final List<CoinHistoryEntity> coinHistoryList;
  final int page;
  final int size;
  final bool isLoadMore;
  final bool cannotLoadMore;

  const CoinLoadSuccess({
    required this.coinHistoryList,
    required this.page,
    required this.size,
    this.isLoadMore = false,
    this.cannotLoadMore = false,
  });

  @override
  List<Object> get props =>
      [coinHistoryList, page, size, isLoadMore, cannotLoadMore,];

  CoinLoadSuccess copyWith({
    List<CoinHistoryEntity>? coinHistoryList,
    int? page,
    int? size,
    bool? isLoadMore,
    bool? cannotLoadMore,
  }) {
    return CoinLoadSuccess(
      coinHistoryList: coinHistoryList ?? this.coinHistoryList,
      page: page ?? this.page,
      size: size ?? this.size,
      isLoadMore: isLoadMore ?? this.isLoadMore,
      cannotLoadMore: cannotLoadMore ?? this.cannotLoadMore,
    );
  }
}

class CoinLoadFailure extends CoinState {
  @override
  List<Object> get props => [];
}