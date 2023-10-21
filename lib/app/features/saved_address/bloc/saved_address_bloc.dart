import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shopfee/app/common/data/global_data.dart';
import 'package:shopfee/data/models/address.dart';
import 'package:shopfee/data/repositories/address/address_repository.dart';

part 'saved_address_event.dart';

part 'saved_address_state.dart';

class SavedAddressBloc extends Bloc<SavedAddressEvent, SavedAddressState> {
  final AddressRepository addressRepository;

  SavedAddressBloc({required this.addressRepository})
      : super(SavedAddressInitial()) {
    on<LoadSavedAddress>(_onLoadSavedAddress);
  }

  FutureOr<void> _onLoadSavedAddress(
      LoadSavedAddress event, Emitter<SavedAddressState> emit) async {
    emit(SavedAddressLoading());
    try {
      EasyLoading.show();
      var response =
          await addressRepository.getAllAddress(GlobalData.ins.userId!);
      EasyLoading.dismiss();
      if (response.success) {
        final List<Address> addressList =
            response.data!.map((e) => Address.fromMap(e)).toList();
        emit(SavedAddressLoaded(addressList: addressList));
      }
    } catch (e) {
      print(e);
    }
  }
}
