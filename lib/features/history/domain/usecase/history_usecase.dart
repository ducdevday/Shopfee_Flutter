import 'package:shopfee/features/history/domain/entities/order_history_entity.dart';
import 'package:shopfee/features/history/domain/entities/order_history_params_entity.dart';
import 'package:shopfee/features/history/domain/repositories/history_repository.dart';

abstract class HistoryUseCase {
  Future<List<OrderHistoryEntity>> getHistoryOrder(
      String userId, OrderHistoryParamsEntity params);
}

class HistoryUseCaseImpl extends HistoryUseCase {
  final HistoryRepository _historyRepository;

  HistoryUseCaseImpl(this._historyRepository);

  @override
  Future<List<OrderHistoryEntity>> getHistoryOrder(
      String userId,OrderHistoryParamsEntity params) async {
    return await _historyRepository.getHistoryOrder(userId, params);
  }
}
