import 'package:dio/dio.dart';
import 'package:shopfee/core/base/dio_service.dart';
import 'package:shopfee/features/review/domain/entities/review_params.dart';

class ReviewService {
  Future<Response> getOrderReviewItem(String orderId) async {
    final response = await DioService.instance
        .get("${DioService.orderPath}/$orderId/order-item");
    return response;
  }

  Future<Response> createNewReview(ReviewParams params) async{
    final response = await DioService.instance.post("${DioService.reviewPath}", data: params.toJson());
    return response;
  }
}
