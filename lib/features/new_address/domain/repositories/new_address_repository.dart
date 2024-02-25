import 'package:shopfee/features/saved_address/domain/entities/address_entity.dart';

abstract class NewAddressRepository {
  Future<void> createAddress(AddressEntity address, String userId);
  Future<void> updateAddress(AddressEntity address, String userId);
  Future<void> deleteAddress(AddressEntity address, String userId);
  Future<AddressEntity> getAddress(String addressId);
}