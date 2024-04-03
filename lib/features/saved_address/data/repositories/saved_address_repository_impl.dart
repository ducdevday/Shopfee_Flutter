import 'package:shopfee/core/common/models/result_list.dart';
import 'package:shopfee/features/saved_address/data/datasources/saved_address_service.dart';
import 'package:shopfee/features/saved_address/data/models/address_model.dart';
import 'package:shopfee/features/saved_address/domain/entities/address_entity.dart';
import 'package:shopfee/features/saved_address/domain/repositories/saved_address_repository.dart';

class SavedAddressRepositoryImpl implements SavedAddressRepository {
  final SavedAddressService _saveAddressService;

  SavedAddressRepositoryImpl(this._saveAddressService);

  @override
  Future<List<AddressEntity>> getAllAddress(String userId) async {
    final response = await _saveAddressService.getAllAddress(userId);
    final result = ResultList(
      success: response.data["success"],
      message: response.data["message"],
      data: response.data["data"],
    );
    List<AddressModel> addressesModel =
        result.data!.map((p) => AddressModel.fromJson(p)).toList();
    List<AddressEntity> addressesEntity =
        addressesModel.map((p) => AddressEntity.fromModel(p)).toList();
    return addressesEntity;
  }
}
