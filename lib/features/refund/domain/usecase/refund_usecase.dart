import 'package:shopfee/features/refund/data/models/refund_request_params.dart';
import 'package:shopfee/features/refund/domain/entities/refund_detail_model.dart';
import 'package:shopfee/features/refund/domain/repositories/refund_repository.dart';

abstract class RefundUseCase {
  Future<void> createRefundRequest(String orderId, RefundRequestParams params);
  Future<RefundDetailEntity> getRefundDetail(String orderId);
}

class RefundUseCaseImpl extends RefundUseCase {
  final RefundRepository _refundRepository;

  RefundUseCaseImpl(this._refundRepository);

  @override
  Future<void> createRefundRequest(
      String orderId, RefundRequestParams params) async {
    return await _refundRepository.createRefundRequest(orderId, params);
  }

  @override
  Future<RefundDetailEntity> getRefundDetail(String orderId) async{
    return await _refundRepository.getRefundDetail(orderId);
  }
}
