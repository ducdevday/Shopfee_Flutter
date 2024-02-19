import 'package:shopfee/core/errors/app_exception.dart';
import 'package:shopfee/features/saved_address/domain/entities/address_entity.dart';
import 'package:shopfee/features/saved_address/domain/repositories/saved_address_repository.dart';
import 'package:shopfee/features/template/domain/entities/template_entity.dart';
import 'package:shopfee/features/template/domain/repositories/template_repository.dart';

abstract class SavedAddressUseCase {
  Future<List<AddressEntity>> getAllAddress(String userId);
}

class SavedAddressUseCaseImpl extends SavedAddressUseCase {
  final SavedAddressRepository _savedAddressRepository;

  SavedAddressUseCaseImpl(this._savedAddressRepository);

  @override
  Future<List<AddressEntity>> getAllAddress(String userId) async {
    return await _savedAddressRepository.getAllAddress(userId);
  }
}
