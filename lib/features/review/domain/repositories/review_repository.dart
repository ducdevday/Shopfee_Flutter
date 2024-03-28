

import 'package:shopfee/features/review/domain/entities/review_information_entity.dart';
import 'package:shopfee/features/review/domain/entities/review_params.dart';

abstract class ReviewRepository {
  Future<List<ReviewInformationEntity>> getOrderReviewItem(String orderId) ;
  Future<void> createNewReview(ReviewParams params);
}