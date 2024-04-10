import 'package:shopfee/core/errors/app_exception.dart';
import 'package:shopfee/features/refund/data/models/refund_request_params.dart';
import 'package:shopfee/features/refund/domain/repositories/refund_repository.dart';
import 'package:shopfee/features/template/domain/entities/template_entity.dart';
import 'package:shopfee/features/template/domain/repositories/template_repository.dart';

abstract class RefundUseCase {
  Future<void> createRefundRequest(String orderId, RefundRequestParams params);
}

class RefundUseCaseImpl extends RefundUseCase {
  final RefundRepository _refundRepository;

  RefundUseCaseImpl(this._refundRepository);

  @override
  Future<void> createRefundRequest(
      String orderId, RefundRequestParams params) async {
    return await _refundRepository.createRefundRequest(orderId, params);
  }
}
