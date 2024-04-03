part of store_detail;

abstract class StoreDetailState extends Equatable {
  const StoreDetailState();
}

class StoreDetailInitial extends StoreDetailState {
  @override
  List<Object> get props => [];
}

class StoreDetailLoadInProcess extends StoreDetailState {
  @override
  List<Object> get props => [];
}

class StoreDetailLoadSuccess extends StoreDetailState {
  final StoreDetailEntity store;

  const StoreDetailLoadSuccess({
    required this.store,
  });

  @override
  List<Object> get props => [store];
}

class StoreDetailLoadFailure extends StoreDetailState {
  @override
  List<Object> get props => [];
}