import 'package:shopfee/core/common/models/order_status.dart';
import 'package:shopfee/features/history/domain/entities/order_history_entity.dart';

abstract class HistoryRepository {
  Future<List<OrderHistoryEntity>> getHistoryOrder(String userId, OrderStatus orderStatus,
      {required int page, required int size});
}