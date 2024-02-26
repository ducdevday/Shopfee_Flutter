part of new_address;

class NewAddressBloc extends Bloc<NewAddressEvent, NewAddressState> {
  final NewAddressUseCase _newAddressUseCase;

  NewAddressBloc(this._newAddressUseCase) : super(NewAddressInitial()) {
    on<NewAddressLoadInformation>(_onNewAddressLoadInformation);
    on<NewAddressDoDelete>(_onNewAddressDoDelete);
    on<NewAddressDoUpdate>(_onNewAddressDoUpdate);
    on<NewAddressDoCreate>(_onNewAddressDoCreate);
  }

  FutureOr<void> _onNewAddressLoadInformation(
      NewAddressLoadInformation event, Emitter<NewAddressState> emit) async {
    try {
      EasyLoading.show(maskType: EasyLoadingMaskType.black);
      final address = await _newAddressUseCase.getAddress(event.addressId);
      EasyLoading.dismiss();
      emit(NewAddressLoadSuccess(address: address));
    } catch (e) {
      ExceptionUtil.handle(e);
    }
  }

  FutureOr<void> _onNewAddressDoCreate(
      NewAddressDoCreate event, Emitter<NewAddressState> emit) async {
    try {
      EasyLoading.show(maskType: EasyLoadingMaskType.black);
      final response = await _newAddressUseCase.createAddress(
          event.address, SharedService.getUserId()!);
      EasyLoading.dismiss();
      EasyLoading.showSuccess("Added New Address");
      emit(NewAddressFinished());
    } catch (e) {
      ExceptionUtil.handle(e);
    }
  }

  FutureOr<void> _onNewAddressDoDelete(
      NewAddressDoDelete event, Emitter<NewAddressState> emit) async {
    try {
      EasyLoading.show(maskType: EasyLoadingMaskType.black);
      final response = await _newAddressUseCase.deleteAddress(event.addressId);
      EasyLoading.dismiss();
      EasyLoading.showSuccess("Deleted Address");
      emit(NewAddressFinished());
    } catch (e) {
      ExceptionUtil.handle(e);
    }
  }

  FutureOr<void> _onNewAddressDoUpdate(
      NewAddressDoUpdate event, Emitter<NewAddressState> emit) async {
    try {
      EasyLoading.show(maskType: EasyLoadingMaskType.black);
      final response = await _newAddressUseCase.updateAddress(event.address);
      EasyLoading.dismiss();
      EasyLoading.showSuccess("Updated Address");
      emit(NewAddressFinished());
    } catch (e) {
      ExceptionUtil.handle(e);
    }
  }
}
