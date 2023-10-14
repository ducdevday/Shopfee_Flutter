part of 'new_address_bloc.dart';

abstract class NewAddressEvent extends Equatable {
  const NewAddressEvent();
}

class LoadNewAddress extends NewAddressEvent {
  final String? addressId;

  const LoadNewAddress({
    required this.addressId,
  });

  @override
  List<Object?> get props => [addressId];
}

class AddLocation extends NewAddressEvent {
  final PlaceSearch placeSearch;

  const AddLocation({required this.placeSearch});

  @override
  List<Object> get props => [placeSearch];
}

class AddNote extends NewAddressEvent {
  final String note;

  const AddNote({this.note = ""});

  @override
  List<Object> get props => [note];
}

class AddRecipientName extends NewAddressEvent {
  final String recipientName;

  const AddRecipientName({
    required this.recipientName,
  });

  @override
  List<Object> get props => [recipientName];
}

class AddPhoneNumber extends NewAddressEvent {
  final String phoneNumber;

  const AddPhoneNumber({
    required this.phoneNumber,
  });

  @override
  List<Object> get props => [phoneNumber];
}

class SetDefault extends NewAddressEvent {
  final bool isDefault;

  SetDefault({required this.isDefault});

  @override
  List<Object> get props => [isDefault];
}

class AddNewAddress extends NewAddressEvent {
  @override
  List<Object> get props => [];
}

class UpdateAddress extends NewAddressEvent {
  @override
  List<Object> get props => [];
}

class DeleteAddress extends NewAddressEvent{
  @override
  List<Object> get props => [];
}

