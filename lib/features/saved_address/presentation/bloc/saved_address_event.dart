part of saved_address;

abstract class SavedAddressEvent extends Equatable {
  const SavedAddressEvent();
}

class SavedAddressLoadInformation extends SavedAddressEvent {
  @override
  List<Object> get props => [];
}