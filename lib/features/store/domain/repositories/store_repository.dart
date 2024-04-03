import 'package:geolocator/geolocator.dart';
import 'package:shopfee/features/store/domain/entities/store_all_params_entity.dart';
import 'package:shopfee/features/store/domain/entities/store_information_entity.dart';

abstract class StoreRepository {
  Future<List<StoreInformationEntity>?> getAllStores(
      StoreAllParamsEntity entity);

  Future<Position> getCurrentPosition();
}
