part of store;

abstract class StoreState extends Equatable {
  const StoreState();
}

class StoreInitial extends StoreState {
  @override
  List<Object> get props => [];
}

class StoreLoadInProcess extends StoreState {
  @override
  List<Object> get props => [];
}

class StoreLoadSuccess extends StoreState {
  final List<StoreInformationEntity> stores;
  final String query;
  final bool getAll;
  final bool isLoadMore;
  final bool cannotLoadMore;
  final Position? currentPosition;
  final StoreViewType viewType;

  const StoreLoadSuccess({
    required this.stores,
    this.query = "",
    required this.getAll,
    this.isLoadMore = false,
    this.cannotLoadMore = false,
    this.currentPosition,
    this.viewType = StoreViewType.List_View
  });

  @override
  List<Object?> get props =>
      [stores,query, getAll, isLoadMore, cannotLoadMore, currentPosition, viewType,];

  StoreLoadSuccess copyWith({
    List<StoreInformationEntity>? stores,
    String? query,
    bool? getAll,
    bool? isLoadMore,
    bool? cannotLoadMore,
    Position? currentPosition,
    StoreViewType? viewType,
  }) {
    return StoreLoadSuccess(
      stores: stores ?? this.stores,
      query: query ?? this.query,
      getAll: getAll ?? this.getAll,
      isLoadMore: isLoadMore ?? this.isLoadMore,
      cannotLoadMore: cannotLoadMore ?? this.cannotLoadMore,
      currentPosition: currentPosition ?? this.currentPosition,
      viewType: viewType ?? this.viewType,
    );
  }
}

class StoreNoLocationPermission extends StoreState {
  @override
  List<Object> get props => [];
}

class StoreLoadFailure extends StoreState {
  @override
  List<Object> get props => [];
}
