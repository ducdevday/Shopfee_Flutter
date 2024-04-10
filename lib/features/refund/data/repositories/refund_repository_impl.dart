import 'package:shopfee/features/refund/data/datasources/refund_service.dart';
import 'package:shopfee/features/refund/data/models/refund_request_params.dart';
import 'package:shopfee/features/refund/domain/repositories/refund_repository.dart';

class RefundRepositoryImpl implements RefundRepository {
  final RefundService _refundService;

  RefundRepositoryImpl(this._refundService);

  @override
  Future<void> createRefundRequest(String orderId,
      RefundRequestParams params) async {
    await _refundService.createRefundRequest(orderId, params);
  }
}
