import 'package:dio/dio.dart';
import 'package:shopfee/core/base/dio_service.dart';
import 'package:shopfee/features/review_detail/data/models/review_detail_params.dart';
import 'package:shopfee/features/review_detail/data/models/review_interact_body.dart';

class ReviewDetailService {
  Future<Response> getReviewStatistic(String productId) async {
    final response = await DioService.instance
        .get("${DioService.reviewPath}/statistic/product/$productId");
    return response;
  }

  Future<Response> getReviewDetailList(
      String productId, ReviewDetailParams params) async {
    final response = await DioService.instance.get(
        "${DioService.reviewPath}/product/$productId",
        queryParameters: params.toJson());
    return response;
  }

  Future<Response> interactReview(
      String productReviewId, ReviewInteractBody body) async {
    final response = await DioService.instance.post(
        "${DioService.reviewPath}/product-review/$productReviewId",
        data: body.toJson());
    return response;
  }
}
