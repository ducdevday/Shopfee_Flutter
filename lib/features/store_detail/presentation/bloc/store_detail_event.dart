part of store_detail;

abstract class StoreDetailEvent extends Equatable {
  const StoreDetailEvent();
}

class StoreDetailLoadInformation extends StoreDetailEvent {
  final String? branchId;

  const StoreDetailLoadInformation({
    this.branchId,
  });

  @override
  List<Object?> get props => [branchId];
}
