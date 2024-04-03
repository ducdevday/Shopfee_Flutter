import 'package:shopfee/features/review_detail/data/models/review_detail_params.dart';
import 'package:shopfee/features/review_detail/data/models/review_interact_body.dart';
import 'package:shopfee/features/review_detail/domain/entities/review_detail_entity.dart';

abstract class ReviewDetailRepository {
  Future<List<ReviewDetailEntity>> getReviewDetailList(String productId, ReviewDetailParams params) ;
  Future<void> interactReview(String productReviewId, ReviewInteractBody body);
}