import 'package:shopfee/core/errors/app_exception.dart';
import 'package:shopfee/features/new_address/domain/repositories/new_address_repository.dart';
import 'package:shopfee/features/saved_address/domain/entities/address_entity.dart';
import 'package:shopfee/features/template/domain/repositories/template_repository.dart';

abstract class NewAddressUseCase {
  Future<void> createAddress(AddressEntity address, String userId);

  Future<void> updateAddress(AddressEntity address);

  Future<void> deleteAddress(String addressId);

  Future<AddressEntity> getAddress(String addressId);
}

class NewAddressUseCaseImpl extends NewAddressUseCase {
  final NewAddressRepository _newAddressRepository;

  NewAddressUseCaseImpl(this._newAddressRepository);

  @override
  Future<void> createAddress(AddressEntity address, String userId) async {
    return await _newAddressRepository.createAddress(address, userId);
  }

  @override
  Future<void> deleteAddress(String addressId) async {
    return await _newAddressRepository.deleteAddress(addressId);
  }

  @override
  Future<AddressEntity> getAddress(String addressId) async {
    return await _newAddressRepository.getAddress(addressId);
  }

  @override
  Future<void> updateAddress(AddressEntity address) async {
    return await _newAddressRepository.updateAddress(address);
  }
}
