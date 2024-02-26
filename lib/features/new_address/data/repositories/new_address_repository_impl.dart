import 'package:shopfee/core/common/models/result.dart';
import 'package:shopfee/features/new_address/data/datasources/new_address_service.dart';
import 'package:shopfee/features/new_address/domain/repositories/new_address_repository.dart';
import 'package:shopfee/features/saved_address/data/models/address_model.dart';
import 'package:shopfee/features/saved_address/domain/entities/address_entity.dart';

class NewAddressRepositoryImpl implements NewAddressRepository {
  final NewAddressService newAddressService;

  NewAddressRepositoryImpl(this.newAddressService);


  @override
  Future<void> createAddress(AddressEntity address, String userId) async {
    final response = await newAddressService.createAddress(
        AddressModel.fromEntity(address), userId);
  }

  @override
  Future<void> deleteAddress(String addressId) async {
    final response = await newAddressService.deleteAddress(addressId);
  }

  @override
  Future<AddressEntity> getAddress(String addressId) async {
    final response = await newAddressService.getAddress(addressId);
    final result = Result(
      success: response.data["success"],
      message: response.data["message"],
      data: response.data["data"],
    );
    final addressModel = AddressModel.fromJson(result.data!);
    final addressEntity = AddressEntity.fromModel(addressModel);
    return addressEntity;
  }

  @override
  Future<void> updateAddress(AddressEntity address) async {
    final response = await newAddressService.updateAddress(
        AddressModel.fromEntity(address));
  }
}
