import 'package:shopfee/features/saved_address/domain/entities/address_entity.dart';

abstract class SavedAddressRepository {
  Future<List<AddressEntity>> getAllAddress(String userId);
}