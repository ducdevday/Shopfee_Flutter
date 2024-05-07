import 'package:shopfee/features/review_detail/data/models/review_detail_params.dart';
import 'package:shopfee/features/review_detail/data/models/review_interact_body.dart';
import 'package:shopfee/features/review_detail/domain/entities/chart_stacked_bar_data.dart';
import 'package:shopfee/features/review_detail/domain/entities/review_detail_entity.dart';
import 'package:shopfee/features/review_detail/domain/entities/review_statistic_entity.dart';

abstract class ReviewDetailRepository {
  Future<List<ChartStackedBarData>> getReviewStatistic(String productId);
  Future<List<ReviewDetailEntity>> getReviewDetailList(String productId, ReviewDetailParams params) ;
  Future<void> interactReview(String productReviewId, ReviewInteractBody body);
}