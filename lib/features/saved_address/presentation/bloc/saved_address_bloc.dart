part of saved_address;

class SavedAddressBloc extends Bloc<SavedAddressEvent, SavedAddressState> {
  final SavedAddressUseCase _savedAddressUseCase;

  SavedAddressBloc(this._savedAddressUseCase) : super(SavedAddressInitial()) {
    on<SavedAddressLoadInformation>(_onSavedAddressLoadInformation);
    on<SavedAddressRefreshInformation>(_onSavedAddressRefreshInformation);
  }

  FutureOr<void> _onSavedAddressLoadInformation(
      SavedAddressLoadInformation event,
      Emitter<SavedAddressState> emit) async {
    try {
      // emit(SavedAddressLoadInProcess());
      EasyLoading.show();
      var savedAddressList =
          await _savedAddressUseCase.getAllAddress(SharedService.getUserId()!);
      EasyLoading.dismiss();
      emit(SavedAddressLoadSuccess(addressList: savedAddressList));
    } catch (e) {
      emit(SavedAddressLoadFailure());
    }
  }

  FutureOr<void> _onSavedAddressRefreshInformation(SavedAddressRefreshInformation event, Emitter<SavedAddressState> emit) async{
    try {
      var savedAddressList =
      await _savedAddressUseCase.getAllAddress(SharedService.getUserId()!);
      emit(SavedAddressLoadSuccess(addressList: savedAddressList));
    } catch (e) {
      emit(SavedAddressLoadFailure());
    }
  }
}
