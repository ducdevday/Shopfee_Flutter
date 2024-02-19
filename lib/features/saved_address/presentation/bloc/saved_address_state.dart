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
    this.addressList = const [],
  });

  @override
  List<Object> get props => [addressList];

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          (other is SavedAddressLoadSuccess &&
              runtimeType == other.runtimeType &&
              addressList == other.addressList);

  @override
  int get hashCode => addressList.hashCode;

  @override
  String toString() {
    return 'SavedAddressLoaded{' + ' addressList: $addressList,' + '}';
  }
}

class SavedAddressLoadFailure extends SavedAddressState {
  @override
  List<Object> get props => [];
}

