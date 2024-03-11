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
  final bool isLoadMore;
  final bool cannotLoadMore;

  const StoreLoadSuccess({
    required this.stores,
    this.isLoadMore = false,
    this.cannotLoadMore = false,
  });

  @override
  List<Object> get props => [stores, isLoadMore, cannotLoadMore];

  StoreLoadSuccess copyWith({
    List<StoreInformationEntity>? stores,
    bool? isLoadMore,
    bool? cannotLoadMore,
  }) {
    return StoreLoadSuccess(
      stores: stores ?? this.stores,
      isLoadMore: isLoadMore ?? this.isLoadMore,
      cannotLoadMore: cannotLoadMore ?? this.cannotLoadMore,
    );
  }
}

class StoreNoLocationPermission extends StoreState {
  @override
  List<Object> get props => [];
}

class StoreEnableLocationPermission extends StoreState {
  final double lat;
  final double lng;

  const StoreEnableLocationPermission({
    required this.lat,
    required this.lng,
  });

  @override
  List<Object> get props => [lat, lng];
}

class StoreLoadFailure extends StoreState {
  @override
  List<Object> get props => [];
}
