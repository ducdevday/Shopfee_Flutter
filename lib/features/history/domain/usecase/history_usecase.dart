import 'package:shopfee/core/common/models/order_status.dart';
import 'package:shopfee/features/history/domain/entities/order_history_entity.dart';
import 'package:shopfee/features/history/domain/repositories/history_repository.dart';

abstract class HistoryUseCase {
  Future<List<OrderHistoryEntity>> getHistoryOrder(
      String userId, OrderStatus orderStatus,
      {required int page, required int size});
}

class HistoryUseCaseImpl extends HistoryUseCase {
  final HistoryRepository _historyRepository;

  HistoryUseCaseImpl(this._historyRepository);

  @override
  Future<List<OrderHistoryEntity>> getHistoryOrder(
      String userId, OrderStatus orderStatus,
      {required int page, required int size}) async {
    return await _historyRepository.getHistoryOrder(userId, orderStatus,
        page: page, size: size);
  }
}
