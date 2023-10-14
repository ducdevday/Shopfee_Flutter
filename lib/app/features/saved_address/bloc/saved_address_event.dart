part of 'saved_address_bloc.dart';

abstract class SavedAddressEvent extends Equatable {
  const SavedAddressEvent();
}

class LoadSavedAddress extends SavedAddressEvent {
  @override
  List<Object> get props => [];
}