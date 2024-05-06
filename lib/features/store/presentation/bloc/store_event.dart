part of store;

abstract class StoreEvent extends Equatable {
  const StoreEvent();
}

class StoreLoadInformation extends StoreEvent {
  final String query;
  final bool getAll;
  final int initPage;
  final int initSize;

  const StoreLoadInformation({
    this.query = "",
    this.getAll = false,
    required this.initPage,
    required this.initSize,
  });

  @override
  List<Object?> get props => [query, getAll, initPage, initSize];
}

class StoreLoadMoreInformation extends StoreEvent {
  const StoreLoadMoreInformation();

  @override
  List<Object?> get props => [];
}

class StoreRefreshInformation extends StoreEvent {
  const StoreRefreshInformation();

  @override
  List<Object?> get props => [];
}

class StoreChangeViewType extends StoreEvent {
  final StoreViewType viewType;

  const StoreChangeViewType({
    required this.viewType,
  });

  @override
  List<Object?> get props => [viewType];
}
