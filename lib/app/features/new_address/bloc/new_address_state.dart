part of 'new_address_bloc.dart';

abstract class NewAddressState extends Equatable {
  const NewAddressState();
}

class NewAddressInitial extends NewAddressState {
  @override
  List<Object> get props => [];
}

class NewAddressLoaded extends NewAddressState{
  final Address address;
  final bool currentDefault;

  NewAddressLoaded({
    required this.address,
    this.currentDefault = false
  });

  bool get isValid => address.details != null && address.longitude != null && address.recipientName != null && address.phoneNumber!= null;

  @override
  List<Object?> get props => [address, currentDefault];
}

class NewAddressFinished extends NewAddressState{
  @override
  List<Object?> get props => [];
}
