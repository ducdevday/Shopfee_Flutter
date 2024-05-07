import 'package:shopfee/core/common/enum/review_interaction_type.dart';
import 'package:shopfee/features/review_detail/data/models/review_detail_params.dart';
import 'package:shopfee/features/review_detail/data/models/review_interact_body.dart';
import 'package:shopfee/features/review_detail/domain/entities/chart_stacked_bar_data.dart';
import 'package:shopfee/features/review_detail/domain/entities/review_detail_entity.dart';
import 'package:shopfee/features/review_detail/domain/entities/review_statistic_entity.dart';
import 'package:shopfee/features/review_detail/domain/repositories/review_detail_repository.dart';

abstract class ReviewDetailUseCase {
  Future<List<ChartStackedBarData>> getReviewStatistic(String productId);

  Future<List<ReviewDetailEntity>> getReviewDetailList(
      String productId, ReviewDetailParams params);

  Future<void> likeReview(String productReviewId, String userId);

  Future<void> disLikeReview(String productReviewId, String userId);
}

class ReviewDetailUseCaseImpl extends ReviewDetailUseCase {
  final ReviewDetailRepository _reviewDetailRepository;

  ReviewDetailUseCaseImpl(this._reviewDetailRepository);

  @override
  Future<List<ReviewDetailEntity>> getReviewDetailList(
      String productId, ReviewDetailParams params) async {
    return await _reviewDetailRepository.getReviewDetailList(productId, params);
  }

  @override
  Future<void> likeReview(String productReviewId, String userId) async {
    final body =
        ReviewInteractBody(userId: userId, type: ReviewInteractionType.LIKE);
    return await _reviewDetailRepository.interactReview(productReviewId, body);
  }

  @override
  Future<void> disLikeReview(String productReviewId, String userId) async {
    final body =
        ReviewInteractBody(userId: userId, type: ReviewInteractionType.DISLIKE);
    return await _reviewDetailRepository.interactReview(productReviewId, body);
  }

  @override
  Future<List<ChartStackedBarData>> getReviewStatistic(String productId) async {
    return await _reviewDetailRepository.getReviewStatistic(productId);
  }
}
