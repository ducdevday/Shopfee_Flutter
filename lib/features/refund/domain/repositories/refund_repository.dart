import 'package:shopfee/features/refund/data/models/refund_request_params.dart';

abstract class RefundRepository {
  Future<void> createRefundRequest(String orderId, RefundRequestParams params);
}
