import 'package:shopfee/core/common/models/result.dart';
import 'package:shopfee/core/common/models/result_list.dart';
import 'package:shopfee/features/receipt/data/datasources/receipt_service.dart';
import 'package:shopfee/features/receipt/data/models/event_log_model.dart';
import 'package:shopfee/features/receipt/data/models/receipt_model.dart';
import 'package:shopfee/features/receipt/domain/entities/event_log_entity.dart';
import 'package:shopfee/features/receipt/domain/entities/receipt_entity.dart';
import 'package:shopfee/features/receipt/domain/repositories/receipt_repository.dart';

class ReceiptRepositoryImpl implements ReceiptRepository {
  final ReceiptService _receiptService;

  ReceiptRepositoryImpl(this._receiptService);

  @override
  Future<ReceiptEntity> getDetailsOrder(String orderId) async {
    final response = await _receiptService.getDetailsOrder(orderId);
    final result = Result(
      success: response.data["success"],
      message: response.data["message"],
      data: response.data["data"],
    );
    final receiptModel = ReceiptModel.fromJson(result.data!);
    final receiptEntity = ReceiptEntity.fromModel(receiptModel);
    return receiptEntity;
  }

  @override
  Future<List<EventLogEntity>> getEventLogsOrder(String orderId) async {
    final response = await _receiptService.getEventLogsOrder(orderId);
    final resultList = ResultList(
      success: response.data["success"],
      message: response.data["message"],
      data: response.data["data"],
    );
    final eventListModel =
    resultList.data!.map((e) => EventLogModel.fromJson(e)).toList();
    List<EventLogEntity> eventListEntity =
    eventListModel.map((e) => EventLogEntity.fromModel(e)).toList();
    return eventListEntity;
  }

  @override
  Future<void> addEventLog(String orderId, EventLogEntity eventLog) async{
    await _receiptService.addEventLog(orderId,EventLogModel.fromEntity(eventLog));
    await _receiptService.sendOrderMessage(
        "Shopfee For Employee Announce",
        "The order ${orderId} was canceled. Please tap to see details",
        orderId);
  }
}