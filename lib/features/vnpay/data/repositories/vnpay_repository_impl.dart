import 'package:shopfee/core/common/models/result.dart';
import 'package:shopfee/features/receipt/data/models/event_log_model.dart';
import 'package:shopfee/features/receipt/domain/entities/event_log_entity.dart';
import 'package:shopfee/features/vnpay/data/datasources/vnpay_service.dart';
import 'package:shopfee/features/vnpay/domain/repositories/vnpay_repository.dart';

class VnPayRepositoryImpl implements VnPayRepository {
  final VnPayService _vnPayService;

  VnPayRepositoryImpl(this._vnPayService);

  @override
  Future<String> updateTransaction(String transactionId) async {
    final response = await _vnPayService.updateTransaction(transactionId);
    final result = Result(
      success: response.data["success"],
      message: response.data["message"],
      data: response.data["data"],
    );
    final String status = result.data!["status"];
    return status;
  }

  @override
  Future<void> addEventLog(String orderId, EventLogEntity eventLog) async{
    await _vnPayService.addEventLog(orderId,EventLogModel.fromEntity(eventLog));
    await _vnPayService.sendOrderMessage(
    "Shopfee For Employee Announce",
    "The order ${orderId} was canceled. Please tap to see details",
    orderId);
  }
}
