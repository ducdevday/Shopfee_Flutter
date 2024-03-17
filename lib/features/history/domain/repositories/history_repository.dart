import 'package:shopfee/features/history/domain/entities/order_history_entity.dart';
import 'package:shopfee/features/history/domain/entities/order_history_params_entity.dart';

abstract class HistoryRepository {
  Future<List<OrderHistoryEntity>> getHistoryOrder(
      String userId, OrderHistoryParamsEntity params);
}
