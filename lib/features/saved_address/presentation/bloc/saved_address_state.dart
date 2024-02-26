part of saved_address;

abstract class SavedAddressState extends Equatable {
  const SavedAddressState();
}

class SavedAddressInitial extends SavedAddressState {
  @override
  List<Object> get props => [];
}

class SavedAddressLoadInProcess extends SavedAddressState {
  @override
  List<Object> get props => [];
}

class SavedAddressLoadSuccess extends SavedAddressState {
  final List<AddressEntity> addressList;

  const SavedAddressLoadSuccess({
    required this.addressList,
  });

  @override
  List<Object> get props => [addressList];
}

class SavedAddressLoadFailure extends SavedAddressState {
  @override
  List<Object> get props => [];
}

