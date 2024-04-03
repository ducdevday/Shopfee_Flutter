import 'package:geolocator/geolocator.dart';
import 'package:shopfee/features/store/domain/entities/store_all_params_entity.dart';
import 'package:shopfee/features/store/domain/entities/store_information_entity.dart';
import 'package:shopfee/features/store/domain/repositories/store_repository.dart';

abstract class StoreUseCase {
  Future<Position> getCurrentPosition();
  Future<List<StoreInformationEntity>?> getAllStores(
      StoreAllParamsEntity entity);

}

class StoreUseCaseImpl extends StoreUseCase {
  final StoreRepository _storeRepository;

  StoreUseCaseImpl(this._storeRepository);

  @override
  Future<List<StoreInformationEntity>?> getAllStores(
      StoreAllParamsEntity entity) async {
    return await _storeRepository.getAllStores(entity);
  }

  @override
  Future<Position> getCurrentPosition() async{
    return await _storeRepository.getCurrentPosition();
  }
}
