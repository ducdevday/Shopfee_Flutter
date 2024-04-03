part of new_address;

abstract class NewAddressEvent extends Equatable {
  const NewAddressEvent();
}

class NewAddressLoadInformation extends NewAddressEvent {
  final String addressId;

  @override
  List<Object> get props => [addressId];

  const NewAddressLoadInformation({
    required this.addressId,
  });
}

class NewAddressDoDelete extends NewAddressEvent{
  final String addressId;

  @override
  List<Object> get props => [addressId];

  const NewAddressDoDelete({
    required this.addressId,
  });
}

class NewAddressDoUpdate extends NewAddressEvent{
  final AddressEntity address;

  @override
  List<Object> get props => [address];

  const NewAddressDoUpdate({
    required this.address,
  });
}

class NewAddressDoCreate extends NewAddressEvent{
  final AddressEntity address;

  @override
  List<Object> get props => [address];

  const NewAddressDoCreate({
    required this.address,
  });
}