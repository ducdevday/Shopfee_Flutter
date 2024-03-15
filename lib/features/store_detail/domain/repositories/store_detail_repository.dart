import 'package:shopfee/features/store_detail/domain/entities/store_detail_entity.dart';

abstract class StoreDetailRepository {
  Future<StoreDetailEntity> getDetailStore(String branchId);
}
