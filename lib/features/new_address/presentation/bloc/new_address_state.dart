part of new_address;

abstract class NewAddressState extends Equatable {
  const NewAddressState();
}

class NewAddressInitial extends NewAddressState {
  @override
  List<Object> get props => [];
}

class NewAddressFinished extends NewAddressState {
  @override
  List<Object> get props => [];
}