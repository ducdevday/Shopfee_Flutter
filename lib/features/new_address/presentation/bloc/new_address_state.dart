part of new_address;

abstract class NewAddressState extends Equatable {
  const NewAddressState();
}

class NewAddressInitial extends NewAddressState {
  @override
  List<Object> get props => [];
}

class NewAddressLoadSuccess extends NewAddressState {
  final AddressEntity address;

  const NewAddressLoadSuccess({
    required this.address,
  });

  @override
  List<Object> get props => [address];
}

class NewAddressFinished extends NewAddressState {
  @override
  List<Object> get props => [];
}