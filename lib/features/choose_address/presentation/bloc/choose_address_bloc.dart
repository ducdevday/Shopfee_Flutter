part of choose_address;

class ChooseAddressBloc extends Bloc<ChooseAddressEvent, ChooseAddressState> {
  final ChooseAddressUseCase _chooseAddressUsecase;

  ChooseAddressBloc(this._chooseAddressUsecase)
      : super(ChooseAddressInitial()) {
    on<ChooseAddressLoadProvince>(_onChooseAddressLoadProvince);
    on<ChooseAddressPickProvince>(_onChooseAddressPickProvince);
    on<ChooseAddressPickDistrict>(_onChooseAddressPickDistrict);
    on<ChooseAddressPickWard>(_onChooseAddressPickWard);
  }

  FutureOr<void> _onChooseAddressLoadProvince(
      ChooseAddressLoadProvince event, Emitter<ChooseAddressState> emit) async {
    try {
      EasyLoading.show();
      final provinceList = await _chooseAddressUsecase.getListProvince();
      EasyLoading.dismiss();
      emit(ChooseAddressLoadSuccess(provinceList: provinceList));
    } catch (e) {
      ExceptionUtil.handle(e);
    }
  }

  FutureOr<void> _onChooseAddressPickProvince(
      ChooseAddressPickProvince event, Emitter<ChooseAddressState> emit) async {
    try {
      if (state is ChooseAddressLoadSuccess) {
        final currentState = state as ChooseAddressLoadSuccess;
        if (event.province != null &&
            event.province?.provinceId !=
                currentState.chosenProvince?.provinceId) {
          EasyLoading.show();
          final districtList = await _chooseAddressUsecase
              .getListDistrict(event.province!.provinceId!);
          EasyLoading.dismiss();
          emit(currentState.copyWith(
            districtList: districtList,
            wardList: [],
            chosenProvince: () => event.province,
            chosenDistrict:() => null,
            chosenWard: () => null,
          ));
        }
      }
    } catch (e) {
      ExceptionUtil.handle(e);
    }
  }

  FutureOr<void> _onChooseAddressPickDistrict(
      ChooseAddressPickDistrict event, Emitter<ChooseAddressState> emit) async {
    try {
      if (state is ChooseAddressLoadSuccess) {
        final currentState = state as ChooseAddressLoadSuccess;
        if (event.district != null &&
            event.district?.districtId !=
                currentState.chosenDistrict?.districtId) {
          EasyLoading.show();
          final wardList = await _chooseAddressUsecase
              .getListWard(event.district!.districtId!);
          EasyLoading.dismiss();
          emit(currentState.copyWith(
            wardList: wardList,
            chosenDistrict: () => event.district,
            chosenWard: () => null,
          ));
        }
      }
    } catch (e) {
      ExceptionUtil.handle(e);
    }
  }

  FutureOr<void> _onChooseAddressPickWard(
      ChooseAddressPickWard event, Emitter<ChooseAddressState> emit) {
    try {
      if (state is ChooseAddressLoadSuccess) {
        final currentState = state as ChooseAddressLoadSuccess;
        if (event.ward != null &&
            event.ward?.wardId != currentState.chosenWard?.wardId) {
          emit(currentState.copyWith(chosenWard: () => event.ward));
        }
      }
    } catch (e) {
      ExceptionUtil.handle(e);
    }
  }
}
