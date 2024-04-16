import 'package:shopfee/core/common/models/result.dart';
import 'package:shopfee/features/refund/data/datasources/refund_service.dart';
import 'package:shopfee/features/refund/data/models/refund_detail_model.dart';
import 'package:shopfee/features/refund/data/models/refund_request_params.dart';
import 'package:shopfee/features/refund/domain/entities/refund_detail_model.dart';
import 'package:shopfee/features/refund/domain/repositories/refund_repository.dart';

class RefundRepositoryImpl implements RefundRepository {
  final RefundService _refundService;

  RefundRepositoryImpl(this._refundService);

  @override
  Future<void> createRefundRequest(
      String orderId, RefundRequestParams params) async {
    await _refundService.createRefundRequest(orderId, params);
  }

  @override
  Future<RefundDetailEntity> getRefundDetail(String orderId) async {
    final response = await _refundService.getRefundDetail(orderId);
    final result = Result(
      success: response.data["success"],
      message: response.data["message"],
      data: response.data["data"],
    );
    final refundDetailModel = RefundDetailModel.fromJson(result.data!);
    final refundDetailEntity = RefundDetailEntity.fromModel(refundDetailModel);
    return refundDetailEntity;
  }
}
