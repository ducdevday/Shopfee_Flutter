import 'package:shopfee/features/review/data/models/review_information_model.dart';
import 'package:shopfee/features/review/domain/entities/review_entity.dart';

class ReviewInformationEntity {
  final String? id;
  final String? name;
  final String? thumbnailUrl;
  final ReviewEntity? review;

  const ReviewInformationEntity({
    this.id,
    this.name,
    this.thumbnailUrl,
    this.review,
  });

  factory ReviewInformationEntity.fromModel(ReviewInformationModel model){
    return ReviewInformationEntity(
        id: model.id,
        name: model.name,
        thumbnailUrl: model.thumbnailUrl,
        review: model.review == null
            ? null
            : ReviewEntity.fromModel(model.review!));
  }
}
