import 'package:shopfee/features/saved_address/domain/entities/address_entity.dart';

abstract class NewAddressRepository {
  Future<void> createAddress(AddressEntity address, String userId);
  Future<void> updateAddress(AddressEntity address);
  Future<void> deleteAddress(String addressId);
  Future<AddressEntity> getAddress(String addressId);
}