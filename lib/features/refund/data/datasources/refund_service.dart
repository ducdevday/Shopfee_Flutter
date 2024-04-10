import 'package:dio/dio.dart';
import 'package:shopfee/core/base/dio_service.dart';
import 'package:shopfee/features/refund/data/models/refund_request_params.dart';

class RefundService {
  Future<Response> createRefundRequest(
      String orderId, RefundRequestParams params) async {
    var formData = FormData();
    for (var file in params.mediaList) {
      String fileName = file.path.split('/').last;
      formData.files.addAll([
        MapEntry(
          "mediaList",
          await MultipartFile.fromFile(file.path, filename: fileName),
        ),
      ]);
    }

    Map<String, dynamic> body = {
      "reason": params.reason,
      "mediaList": formData,
      "note": params.note
    };

    final response = await DioService.instance
        .get("${DioService.refundPath}/$orderId", data: body);

    return response;
  }
}
