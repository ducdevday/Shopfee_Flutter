import 'package:shopfee/features/review/data/models/review_model.dart';
import 'package:shopfee/features/template/data/models/template_model.dart';

class ReviewEntity {
  final int star;
  final String? content;
  final DateTime? createdAt;

  const ReviewEntity({
    required this.star,
    this.content,
    this.createdAt,
  });

  factory ReviewEntity.fromModel(ReviewModel model) {
    return ReviewEntity(
        star: model.star, content: model.content, createdAt: model.createdAt);
  }
}
