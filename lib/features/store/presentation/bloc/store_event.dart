part of store;

abstract class StoreEvent extends Equatable {
  const StoreEvent();
}

class StoreLoadInformation extends StoreEvent {
  final bool getAll;
  final int page;
  final int size;

  const StoreLoadInformation({
    this.getAll = false,
    required this.page,
    required this.size,
  });

  @override
  List<Object?> get props => [getAll, page, size];
}

class StoreLoadMoreInformation extends StoreEvent {
  final int page;
  final int size;

  const StoreLoadMoreInformation({
    required this.page,
    required this.size,
  });

  @override
  List<Object?> get props => [page, size];
}

class StoreChangeViewType extends StoreEvent {
  final StoreViewType viewType;

  const StoreChangeViewType({
    required this.viewType,
  });

  @override
  List<Object?> get props => [viewType];
}
