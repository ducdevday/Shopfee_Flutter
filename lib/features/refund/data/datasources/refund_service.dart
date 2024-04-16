import 'package:dio/dio.dart';
import 'package:shopfee/core/base/dio_service.dart';
import 'package:shopfee/features/refund/data/models/refund_request_params.dart';

class RefundService {
  Future<Response> createRefundRequest(
      String orderId, RefundRequestParams params) async {
    FormData formData = FormData.fromMap({
      "reason": params.reason,
      "mediaList": params.mediaList
          .map((item) => MultipartFile.fromFileSync(item.path,
              filename: item.path.split('/').last))
          .toList(),
      "note": params.note
    });

    final response = await DioService.instance
        .post("${DioService.refundPath}/$orderId", data: formData);

    return response;
  }

  Future<Response> getRefundDetail(String orderId) async {
    final response =
        await DioService.instance.get("${DioService.refundPath}/$orderId");
    return response;
  }
}
