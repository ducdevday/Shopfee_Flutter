import 'package:shopfee/features/receipt/domain/entities/event_log_entity.dart';
import 'package:shopfee/features/receipt/domain/entities/receipt_entity.dart';

abstract class ReceiptRepository {
  Future<ReceiptEntity> getDetailsOrder(String orderId);
  Future<List<EventLogEntity>> getEventLogsOrder(String orderId);
  Future<void> addEventLog(String orderId, EventLogEntity eventLog);
}