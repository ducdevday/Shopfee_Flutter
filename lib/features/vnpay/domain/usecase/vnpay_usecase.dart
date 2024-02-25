import 'package:shopfee/core/errors/app_exception.dart';
import 'package:shopfee/features/receipt/domain/entities/event_log_entity.dart';

import 'package:shopfee/features/template/domain/repositories/template_repository.dart';
import 'package:shopfee/features/vnpay/domain/repositories/vnpay_repository.dart';

abstract class VnPayUseCase {
  Future<String> updateTransaction(String transactionId);

  Future<void> addEventLog(String orderId, EventLogEntity eventLog);
}

class VnPayUseCaseImpl extends VnPayUseCase {
  final VnPayRepository _vnPayRepository;

  VnPayUseCaseImpl(this._vnPayRepository);

  @override
  Future<String> updateTransaction(String transactionId) async {
    return await _vnPayRepository.updateTransaction(transactionId);
  }

  @override
  Future<void> addEventLog(String orderId, EventLogEntity eventLog) async {
    return await _vnPayRepository.addEventLog(orderId, eventLog);
  }
}
