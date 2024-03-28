import 'package:shopfee/core/errors/app_exception.dart';
import 'package:shopfee/features/review/domain/entities/review_information_entity.dart';
import 'package:shopfee/features/review/domain/entities/review_params.dart';
import 'package:shopfee/features/review/domain/repositories/review_repository.dart';
import 'package:shopfee/features/template/domain/entities/template_entity.dart';
import 'package:shopfee/features/template/domain/repositories/template_repository.dart';

abstract class ReviewUseCase {
  Future<List<ReviewInformationEntity>> getOrderReviewItem(String orderId);

  Future<void> createNewReview(ReviewParams params);
}

class ReviewUseCaseImpl extends ReviewUseCase {
  final ReviewRepository _reviewRepository;

  ReviewUseCaseImpl(this._reviewRepository);

  @override
  Future<List<ReviewInformationEntity>> getOrderReviewItem(
      String orderId) async {
    return await _reviewRepository.getOrderReviewItem(orderId);
  }

  @override
  Future<void> createNewReview(ReviewParams params) async {
    return await _reviewRepository.createNewReview(params);
  }
}
