import 'package:shopfee/core/common/models/order_status.dart';
import 'package:shopfee/core/socket/socket_method.dart';
import 'package:shopfee/features/receipt/domain/entities/event_log_entity.dart';
import 'package:shopfee/features/receipt/domain/entities/receipt_entity.dart';
import 'package:shopfee/features/receipt/domain/repositories/receipt_repository.dart';

abstract class ReceiptUseCase {
  Future<ReceiptEntity> getDetailsOrder(String orderId);

  Future<List<EventLogEntity>> getEventLogsOrder(String orderId);

  Future<void> cancelOrder(String branchId, String orderId, String reason);

  Future<void> requestCancelOrder(String branchId, String orderId, String reason);

  OrderStatus? determineCancelType(EventLogEntity lastEventLog);
}

class ReceiptUseCaseImpl extends ReceiptUseCase {
  final ReceiptRepository _receiptRepository;
  final SocketMethod _socketMethod;

  ReceiptUseCaseImpl(this._receiptRepository, this._socketMethod);

  @override
  Future<ReceiptEntity> getDetailsOrder(String orderId) async {
    return await _receiptRepository.getDetailsOrder(orderId);
  }

  @override
  Future<List<EventLogEntity>> getEventLogsOrder(String orderId) async {
    final eventLogs = await _receiptRepository.getEventLogsOrder(orderId);
    return eventLogs;
  }

  @override
  Future<void> cancelOrder(String branchId, String orderId, String reason) async {
    final result = await _receiptRepository.cancelOrder(orderId, reason);
    _socketMethod.updateOrder(branchId: branchId, orderId: orderId);
    return result;
  }

  @override
  Future<void> requestCancelOrder(String branchId, String orderId, String reason) async {
    final result = await _receiptRepository.requestCancelOrder(orderId, reason);
    _socketMethod.updateOrder(branchId: branchId, orderId: orderId);
    return result;
  }

  @override
  OrderStatus? determineCancelType(EventLogEntity lastEventLog) {
    if (lastEventLog.orderStatus == OrderStatus.CREATED &&
        isWithin30Minutes(lastEventLog.time!, DateTime.now())) {
      return OrderStatus.CANCELED;
    } else if (lastEventLog.orderStatus == OrderStatus.CREATED &&
            !isWithin30Minutes(lastEventLog.time!, DateTime.now()) ||
        lastEventLog.orderStatus == OrderStatus.ACCEPTED) {
      return OrderStatus.CANCELLATION_REQUEST;
    }
    return null;
  }

  bool isWithin30Minutes(DateTime dateTime1, DateTime dateTime2) {
    Duration difference = dateTime1.difference(dateTime2).abs();
    return difference <= Duration(minutes: 30);
  }
}
