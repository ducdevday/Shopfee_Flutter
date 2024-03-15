import 'package:shopfee/features/receipt/domain/entities/event_log_entity.dart';
import 'package:shopfee/features/receipt/domain/entities/receipt_entity.dart';

abstract class ReceiptRepository {
  Future<ReceiptEntity> getDetailsOrder(String orderId);
  Future<List<EventLogEntity>> getEventLogsOrder(String orderId);
  Future<void> cancelOrder(String orderId, String reason);
  Future<void> requestCancelOrder(String orderId, String reason);
}