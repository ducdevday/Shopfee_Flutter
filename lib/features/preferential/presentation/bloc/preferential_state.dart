part of preferential;

abstract class PreferentialState extends Equatable {
  const PreferentialState();
}

class PreferentialInitial extends PreferentialState {
  @override
  List<Object> get props => [];
}

class PreferentialLoadInProcess extends PreferentialState {
  @override
  List<Object> get props => [];
}

class PreferentialLoadSuccess extends PreferentialState {
  final List<CouponByTypeEntity> coupons;

  const PreferentialLoadSuccess({
    required this.coupons,
  });

  @override
  List<Object> get props => [coupons];
}

class PreferentialLoadFailure extends PreferentialState {
  @override
  List<Object> get props => [];
}
