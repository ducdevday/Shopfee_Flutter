part of choose_address;

abstract class ChooseAddressState extends Equatable {
  const ChooseAddressState();
}

class ChooseAddressInitial extends ChooseAddressState {
  @override
  List<Object> get props => [];
}

class ChooseAddressLoadInProcess extends ChooseAddressState {
  @override
  List<Object> get props => [];
}

class ChooseAddressLoadSuccess extends ChooseAddressState {
  final List<ProvinceEntity> provinceList;
  final List<DistrictEntity> districtList;
  final List<WardEntity> wardList;
  final ProvinceEntity? chosenProvince;
  final DistrictEntity? chosenDistrict;
  final WardEntity? chosenWard;

  @override
  List<Object?> get props => [
        provinceList,
        districtList,
        wardList,
        chosenProvince,
        chosenDistrict,
        chosenWard,
      ];

  const ChooseAddressLoadSuccess({
    this.provinceList = const <ProvinceEntity>[],
    this.districtList = const <DistrictEntity>[],
    this.wardList = const <WardEntity>[],
    this.chosenProvince,
    this.chosenDistrict,
    this.chosenWard,
  });

  ChooseAddressLoadSuccess copyWith({
    List<ProvinceEntity>? provinceList,
    List<DistrictEntity>? districtList,
    List<WardEntity>? wardList,
    ValueGetter<ProvinceEntity?>? chosenProvince,
    ValueGetter<DistrictEntity?>? chosenDistrict,
    ValueGetter<WardEntity?>? chosenWard,
  }) {
    return ChooseAddressLoadSuccess(
      provinceList: provinceList ?? this.provinceList,
      districtList: districtList ?? this.districtList,
      wardList: wardList ?? this.wardList,
      chosenProvince:
          chosenProvince != null ? chosenProvince() : this.chosenProvince,
      chosenDistrict:
          chosenDistrict != null ? chosenDistrict() : this.chosenDistrict,
      chosenWard: chosenWard != null ? chosenWard() : this.chosenWard,
    );
  }
}

class ChooseAddressLoadFailure extends ChooseAddressState {
  @override
  List<Object> get props => [];
}
