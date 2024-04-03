part of choose_address;

abstract class ChooseAddressEvent extends Equatable {
  const ChooseAddressEvent();
}

class ChooseAddressLoadProvince extends ChooseAddressEvent {
  @override
  List<Object> get props => [];
}

class ChooseAddressPickProvince extends ChooseAddressEvent {
  final ProvinceEntity? province;

  const ChooseAddressPickProvince({
    required this.province,
  });

  @override
  List<Object?> get props => [province];
}

class ChooseAddressPickDistrict extends ChooseAddressEvent {
  final DistrictEntity? district;

  const ChooseAddressPickDistrict({
    required this.district,
  });

  @override
  List<Object?> get props => [district];
}

class ChooseAddressPickWard extends ChooseAddressEvent {
  final WardEntity? ward;

  const ChooseAddressPickWard({
    required this.ward,
  });

  @override
  List<Object?> get props => [ward];
}
