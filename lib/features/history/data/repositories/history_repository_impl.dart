import 'package:shopfee/core/common/models/result.dart';
import 'package:shopfee/core/common/models/result_list.dart';
import 'package:shopfee/features/history/data/datasources/history_service.dart';
import 'package:shopfee/features/history/data/models/order_history_model.dart';
import 'package:shopfee/features/history/data/models/order_history_params_model.dart';
import 'package:shopfee/features/history/domain/entities/order_history_entity.dart';
import 'package:shopfee/features/history/domain/entities/order_history_params_entity.dart';
import 'package:shopfee/features/history/domain/repositories/history_repository.dart';

class HistoryRepositoryImpl implements HistoryRepository {
  final HistoryService _historyService;

  HistoryRepositoryImpl(this._historyService);

  @override
  Future<List<OrderHistoryEntity>> getHistoryOrder(
      String userId, OrderHistoryParamsEntity params) async {
    final response = await _historyService.getHistoryOrder(
        userId, OrderHistoryParamsModel.fromEntity(params));
    final result = Result(
        success: response.data["success"],
        message: response.data["message"],
        data: response.data["data"]);
    final List<dynamic> orderList = result.data!["orderList"] as List<dynamic>;
    List<OrderHistoryModel> orderHistoriesModel =
        orderList.map((c) => OrderHistoryModel.fromJson(c)).toList();
    List<OrderHistoryEntity> orderHistoriesEntity = orderHistoriesModel
        .map((c) => OrderHistoryEntity.fromModel(c))
        .toList();
    return orderHistoriesEntity;
  }
}
