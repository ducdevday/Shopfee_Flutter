import 'package:shopfee/core/common/models/result_list.dart';
import 'package:shopfee/features/review/data/datasources/review_service.dart';
import 'package:shopfee/features/review/data/models/review_information_model.dart';
import 'package:shopfee/features/review/domain/entities/review_information_entity.dart';
import 'package:shopfee/features/review/domain/entities/review_params.dart';
import 'package:shopfee/features/review/domain/repositories/review_repository.dart';

class ReviewRepositoryImpl implements ReviewRepository {
  final ReviewService _reviewService;

  ReviewRepositoryImpl(this._reviewService);

  @override
  Future<List<ReviewInformationEntity>> getOrderReviewItem(
      String orderId) async {
    final response = await _reviewService.getOrderReviewItem(orderId);
    final result = ResultList(
      success: response.data["success"],
      message: response.data["message"],
      data: response.data["data"],
    );
    List<ReviewInformationModel> reviewsInformationModel =
        result.data!.map((p) => ReviewInformationModel.fromJson(p)).toList();
    List<ReviewInformationEntity> reviewsInformationEntity =
        reviewsInformationModel
            .map((p) => ReviewInformationEntity.fromModel(p))
            .toList();
    return reviewsInformationEntity;
  }

  @override
  Future<void> createNewReview(ReviewParams params) async {
    final response = await _reviewService.createNewReview(params);
  }
}
