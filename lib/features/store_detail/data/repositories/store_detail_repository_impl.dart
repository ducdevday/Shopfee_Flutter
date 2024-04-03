import 'package:shopfee/core/common/models/result.dart';
import 'package:shopfee/features/store_detail/data/datasources/store_detail_service.dart';
import 'package:shopfee/features/store_detail/data/models/store_detail_model.dart';
import 'package:shopfee/features/store_detail/domain/entities/store_detail_entity.dart';
import 'package:shopfee/features/store_detail/domain/repositories/store_detail_repository.dart';

class StoreDetailRepositoryImpl implements StoreDetailRepository {
  final StoreDetailService _storeDetailService;

  StoreDetailRepositoryImpl(this._storeDetailService);

  @override
  Future<StoreDetailEntity> getDetailStore(String branchId) async{
    final response = await _storeDetailService.getDetailStore(branchId);
    final result = Result(
      success: response.data["success"],
      message: response.data["message"],
      data: response.data["data"],
    );
    final storeModel = StoreDetailModel.fromJson(result.data!);
    final storeEntity = StoreDetailEntity.fromModel(storeModel);
    return storeEntity;
  }
}
