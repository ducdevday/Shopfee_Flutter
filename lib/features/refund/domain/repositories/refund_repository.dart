import 'package:shopfee/features/refund/data/models/refund_request_params.dart';
import 'package:shopfee/features/refund/domain/entities/refund_detail_model.dart';

abstract class RefundRepository {
  Future<void> createRefundRequest(String orderId, RefundRequestParams params);
  Future<RefundDetailEntity> getRefundDetail(String orderId);
}
