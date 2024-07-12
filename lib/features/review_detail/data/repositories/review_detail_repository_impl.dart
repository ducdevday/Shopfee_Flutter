import 'package:shopfee/core/common/models/result.dart';
import 'package:shopfee/features/review_detail/data/datasources/review_detail_service.dart';
import 'package:shopfee/features/review_detail/data/models/review_detail_model.dart';
import 'package:shopfee/features/review_detail/data/models/review_detail_params.dart';
import 'package:shopfee/features/review_detail/data/models/review_interact_body.dart';
import 'package:shopfee/features/review_detail/data/models/review_statistic_model.dart';
import 'package:shopfee/features/review_detail/domain/entities/chart_stacked_bar_data.dart';
import 'package:shopfee/features/review_detail/domain/entities/review_detail_entity.dart';
import 'package:shopfee/features/review_detail/domain/entities/review_statistic_entity.dart';
import 'package:shopfee/features/review_detail/domain/repositories/review_detail_repository.dart';

class ReviewDetailRepositoryImpl implements ReviewDetailRepository {
  final ReviewDetailService _reviewDetailService;

  ReviewDetailRepositoryImpl(this._reviewDetailService);

  @override
  Future<List<ReviewDetailEntity>> getReviewDetailList(
      String productId, ReviewDetailParams params) async {
    final response =
        await _reviewDetailService.getReviewDetailList(productId, params);
    final result = Result(
      success: response.data["success"],
      message: response.data["message"],
      data: response.data["data"],
    );
    final reviewDetailJsonList =
        result.data!["productReviewList"] as List<dynamic>;
    final reviewDetailModelList =
        reviewDetailJsonList.map((e) => ReviewDetailModel.fromJson(e)).toList();
    final reviewDetailEntityList = reviewDetailModelList
        .map((e) => ReviewDetailEntity.fromModel(e))
        .toList();
    return reviewDetailEntityList;
  }

  @override
  Future<void> interactReview(
      String productReviewId, ReviewInteractBody body) async {
    final response =
        await _reviewDetailService.interactReview(productReviewId, body);
  }

  @override
  Future<List<ChartStackedBarData>> getReviewStatistic(String productId) async {
    final response = await _reviewDetailService.getReviewStatistic(productId);
    final result = Result(
      success: response.data["success"],
      message: response.data["message"],
      data: response.data["data"],
    );
    final reviewStatisticModel = ReviewStatisticModel.fromJson(result.data!);
    final List<ChartStackedBarData> reviewStatistic = reviewStatisticModel
        .statistics
        .map((e) => ChartStackedBarData.fromModel(
            reviewStatisticModel.reviewCountTotal, e))
        .toList();
    return reviewStatistic;
  }
}
