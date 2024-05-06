import 'package:shopfee/features/receipt/domain/entities/event_log_entity.dart';
import 'package:shopfee/features/template/domain/entities/template_entity.dart';

abstract class VnPayRepository {
  Future<void> updateTransaction(String transactionId);

  Future<void> addEventLog(String orderId, EventLogEntity eventLog);
}
