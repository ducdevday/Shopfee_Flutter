import 'package:shopfee/core/common/models/order_status.dart';
import 'package:shopfee/core/common/models/result_list.dart';
import 'package:shopfee/features/history/data/datasources/history_service.dart';
import 'package:shopfee/features/history/data/models/order_history_model.dart';
import 'package:shopfee/features/history/domain/entities/order_history_entity.dart';
import 'package:shopfee/features/history/domain/repositories/history_repository.dart';

class HistoryRepositoryImpl implements HistoryRepository {
  final HistoryService _historyService;

  HistoryRepositoryImpl(this._historyService);

  @override
  Future<List<OrderHistoryEntity>> getHistoryOrder(
      String userId, OrderStatus orderStatus,
      {required int page, required int size}) async {
    final response = await _historyService.getHistoryOrder(userId, orderStatus,
        page: page, size: size);
    final resultList = ResultList(
        success: response.data["success"],
        message: response.data["message"],
        data: response.data["data"]);
    List<OrderHistoryModel> orderHistoriesModel =
        resultList.data!.map((c) => OrderHistoryModel.fromJson(c)).toList();
    List<OrderHistoryEntity> orderHistoriesEntity = orderHistoriesModel
        .map((c) => OrderHistoryEntity.fromModel(c))
        .toList();
    return orderHistoriesEntity;
  }
}
