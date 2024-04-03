import 'package:shopfee/core/common/models/order_status.dart';
import 'package:shopfee/features/receipt/domain/entities/event_log_entity.dart';
import 'package:shopfee/features/receipt/domain/entities/receipt_entity.dart';
import 'package:shopfee/features/receipt/domain/repositories/receipt_repository.dart';

abstract class ReceiptUseCase {
  Future<ReceiptEntity> getDetailsOrder(String orderId);

  Future<EventLogEntity> getLastStatusOrder(String orderId);

  Future<void> cancelOrder(String orderId, String reason);

  Future<void> requestCancelOrder(String orderId, String reason);

  OrderStatus? determineCancelType(EventLogEntity lastEventLog);
}

class ReceiptUseCaseImpl extends ReceiptUseCase {
  final ReceiptRepository _receiptRepository;

  ReceiptUseCaseImpl(this._receiptRepository);

  @override
  Future<ReceiptEntity> getDetailsOrder(String orderId) async {
    return await _receiptRepository.getDetailsOrder(orderId);
  }

  @override
  Future<EventLogEntity> getLastStatusOrder(String orderId) async {
    final eventLogs = await _receiptRepository.getEventLogsOrder(orderId);
    final lastEventLog = eventLogs[0];
    return lastEventLog;
  }

  @override
  Future<void> cancelOrder(String orderId, String reason) async {
    return await _receiptRepository.cancelOrder(orderId, reason);
  }

  @override
  Future<void> requestCancelOrder(String orderId, String reason) async {
    return await _receiptRepository.requestCancelOrder(orderId, reason);
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
