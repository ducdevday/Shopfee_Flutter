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
      NewAddressLoadInformation event, Emitter<NewAddressState> emit) {}

  FutureOr<void> _onNewAddressDoDelete(
      NewAddressDoDelete event, Emitter<NewAddressState> emit) {}

  FutureOr<void> _onNewAddressDoUpdate(
      NewAddressDoUpdate event, Emitter<NewAddressState> emit) {}

  FutureOr<void> _onNewAddressDoCreate(
      NewAddressDoCreate event, Emitter<NewAddressState> emit) {}
}
