part of preferential;

abstract class PreferentialEvent extends Equatable {
  const PreferentialEvent();
}

class PreferentialLoadTopCoupon extends PreferentialEvent {
  final int quantityTop;

  const PreferentialLoadTopCoupon({
    required this.quantityTop,
  });

  @override
  List<Object> get props => [quantityTop];
}

class PreferentialRefreshTopCoupon extends PreferentialEvent {
  final int quantityTop;

  const PreferentialRefreshTopCoupon({
    required this.quantityTop,
  });

  @override
  List<Object> get props => [quantityTop];
}

