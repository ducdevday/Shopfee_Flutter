import 'package:shopfee/core/errors/app_exception.dart';
import 'package:shopfee/features/receipt/domain/entities/event_log_entity.dart';
import 'package:shopfee/features/receipt/domain/entities/receipt_entity.dart';
import 'package:shopfee/features/receipt/domain/repositories/receipt_repository.dart';
import 'package:shopfee/features/template/domain/entities/template_entity.dart';
import 'package:shopfee/features/template/domain/repositories/template_repository.dart';

abstract class ReceiptUseCase {
  Future<ReceiptEntity> getDetailsOrder(String orderId);

  Future<EventLogEntity> getLastStatusOrder(String orderId);

  Future<void> addEventLog(String orderId, EventLogEntity eventLog);
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
    final lastEventLog = eventLogs[eventLogs.length - 1];
    return lastEventLog;
  }

  @override
  Future<void> addEventLog(String orderId, EventLogEntity eventLog) async {
    return await _receiptRepository.addEventLog(orderId, eventLog);
  }
}
