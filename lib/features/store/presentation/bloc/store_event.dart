part of store;

abstract class StoreEvent extends Equatable {
  const StoreEvent();
}

class StoreLoadInformation extends StoreEvent {
  final int page;
  final int size;

  const StoreLoadInformation({
    required this.page,
    required this.size,
  });

  @override
  List<Object?> get props => [page, size];
}

class StoreLoadMoreInformation extends StoreEvent {
  final double? lat;
  final double? lng;
  final int page;
  final int size;

  const StoreLoadMoreInformation({
    required this.lat,
    required this.lng,
    required this.page,
    required this.size,
  });

  @override
  List<Object?> get props => [lat, lng, page, size];
}
