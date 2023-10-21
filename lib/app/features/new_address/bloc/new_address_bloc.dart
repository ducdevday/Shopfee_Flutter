import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shopfee/app/common/data/global_data.dart';
import 'package:shopfee/data/models/address.dart';
import 'package:shopfee/data/models/place_search.dart';
import 'package:shopfee/data/repositories/address/address_repository.dart';

part 'new_address_event.dart';

part 'new_address_state.dart';

class NewAddressBloc extends Bloc<NewAddressEvent, NewAddressState> {
  final AddressRepository addressRepository;

  NewAddressBloc({required this.addressRepository})
      : super(NewAddressInitial()) {
    on<LoadNewAddress>(_onLoadNewAddress);
    on<AddLocation>(_onAddLocation);
    on<AddNote>(_onAddNote);
    on<AddRecipientName>(_onAddRecipientName);
    on<AddPhoneNumber>(_onAddPhoneNumber);
    on<SetDefault>(_onSetDefault);
    on<AddNewAddress>(_onAddNewAddress);
    on<UpdateAddress>(_onUpdateAddress);
    on<DeleteAddress>(_onDeleteAddress);
  }

  FutureOr<void> _onLoadNewAddress(
      LoadNewAddress event, Emitter<NewAddressState> emit) async {
    try {
      if (event.addressId != null) {
        EasyLoading.show();
        var response = await addressRepository.getAddress(event.addressId!);
        EasyLoading.dismiss();
        if (response.success) {
          final address = Address.fromMapFull(response.data!);
          emit(NewAddressLoaded(address: address, currentDefault: address.isDefault!));
        }
      } else {
        emit(NewAddressLoaded(address: const Address()));
      }
    } catch (e) {
      EasyLoading.showError(e.toString());
    }
  }

  FutureOr<void> _onAddLocation(
      AddLocation event, Emitter<NewAddressState> emit) {
    if (state is NewAddressLoaded) {
      final currentState = state as NewAddressLoaded;
      final details =
          "${event.placeSearch.name} ${event.placeSearch.formattedAddress}";
      final latitude = event.placeSearch.lat;
      final longitude = event.placeSearch.lng;
      emit(NewAddressLoaded(
          address: currentState.address.copyWith(
              details: details, latitude: latitude, longitude: longitude)));
    }
  }

  FutureOr<void> _onAddNote(AddNote event, Emitter<NewAddressState> emit) {
    if (state is NewAddressLoaded) {
      final currentState = state as NewAddressLoaded;
      emit(NewAddressLoaded(
          address: currentState.address.copyWith(note: event.note)));
    }
  }

  FutureOr<void> _onAddRecipientName(
      AddRecipientName event, Emitter<NewAddressState> emit) {
    if (state is NewAddressLoaded) {
      final currentState = state as NewAddressLoaded;
      emit(NewAddressLoaded(
          address: currentState.address
              .copyWith(recipientName: event.recipientName)));
    }
  }

  FutureOr<void> _onAddPhoneNumber(
      AddPhoneNumber event, Emitter<NewAddressState> emit) {
    if (state is NewAddressLoaded) {
      final currentState = state as NewAddressLoaded;
      emit(NewAddressLoaded(
          address:
              currentState.address.copyWith(phoneNumber: event.phoneNumber)));
    }
  }

  FutureOr<void> _onSetDefault(SetDefault event, Emitter<NewAddressState> emit) {
    if (state is NewAddressLoaded) {
      final currentState = state as NewAddressLoaded;
      emit(NewAddressLoaded(
          address:
          currentState.address.copyWith(isDefault: event.isDefault)));
    }
  }

  FutureOr<void> _onAddNewAddress(
      AddNewAddress event, Emitter<NewAddressState> emit) async {
    if (state is NewAddressLoaded) {
      try {
        final currentState = state as NewAddressLoaded;
        EasyLoading.show();
        var response = await addressRepository.createAddress(
            currentState.address, GlobalData.ins.userId!);
        EasyLoading.dismiss();
        if (response.success) {
          emit(NewAddressFinished());
        } else {
          EasyLoading.showError(response.message);
        }
      } catch (e) {
        EasyLoading.showError(e.toString());
      }
    }
  }

  FutureOr<void> _onUpdateAddress(
      UpdateAddress event, Emitter<NewAddressState> emit) async {
    if (state is NewAddressLoaded) {
      try {
        final currentState = state as NewAddressLoaded;
        EasyLoading.show();
        var response =
            await addressRepository.updateAddress(currentState.address);
        EasyLoading.dismiss();
        if (response.success) {
          emit(NewAddressFinished());
        } else {
          EasyLoading.showError(response.message);
        }
      } catch (e) {
        EasyLoading.showError(e.toString());
      }
    }
  }

  FutureOr<void> _onDeleteAddress(DeleteAddress event, Emitter<NewAddressState> emit) async{
    if (state is NewAddressLoaded) {
      try {
        final currentState = state as NewAddressLoaded;
        EasyLoading.show();
        var response =
            await addressRepository.deleteAddress(currentState.address.id!);
        EasyLoading.dismiss();
        if (response.success) {
          emit(NewAddressFinished());
        } else {
          EasyLoading.showError(response.message);
        }
      } catch (e) {
        EasyLoading.showError(e.toString());
      }
    }
  }
}
