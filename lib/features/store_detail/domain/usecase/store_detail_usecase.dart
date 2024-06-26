import 'package:shopfee/features/store_detail/domain/entities/store_detail_entity.dart';
import 'package:shopfee/features/store_detail/domain/repositories/store_detail_repository.dart';

abstract class StoreDetailUseCase {
  Future<StoreDetailEntity> getDetailStore(String branchId);
}

class StoreDetailUseCaseImpl extends StoreDetailUseCase {
  final StoreDetailRepository _storeDetailRepository;

  StoreDetailUseCaseImpl(this._storeDetailRepository);

  @override
  Future<StoreDetailEntity> getDetailStore(String branchId) async {
    return await _storeDetailRepository.getDetailStore(branchId);
  }
}
