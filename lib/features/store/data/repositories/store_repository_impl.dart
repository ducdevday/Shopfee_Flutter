import 'package:geolocator/geolocator.dart';
import 'package:shopfee/core/common/models/result.dart';
import 'package:shopfee/features/store/data/datasources/store_service.dart';
import 'package:shopfee/features/store/data/models/store_all_params_model.dart';
import 'package:shopfee/features/store/data/models/store_all_result.dart';
import 'package:shopfee/features/store/domain/entities/store_all_params_entity.dart';
import 'package:shopfee/features/store/domain/entities/store_information_entity.dart';
import 'package:shopfee/features/store/domain/repositories/store_repository.dart';

class StoreRepositoryImpl implements StoreRepository {
  final StoreService _storeService;

  StoreRepositoryImpl(this._storeService);

  @override
  Future<Position> getCurrentPosition() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    return position;
  }

  @override
  Future<List<StoreInformationEntity>?> getAllStores(
      StoreAllParamsEntity entity) async {
    final params = StoreAllParamsModel.fromEntity(entity);
    final response = await _storeService.getAllStores(params);
    final result = Result(
      success: response.data["success"],
      message: response.data["message"],
      data: response.data["data"],
    );
    final storesModel = StoreAllResult.fromJson(result.data!);
    final storesEntity = storesModel.branchList
        ?.map((p) => StoreInformationEntity.fromModel(p))
        .toList();
    return storesEntity;
  }
}
