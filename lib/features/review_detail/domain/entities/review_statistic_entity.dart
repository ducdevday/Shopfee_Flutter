import 'package:shopfee/features/review_detail/data/models/review_statistic_model.dart';
import 'package:shopfee/features/review_detail/domain/entities/review_statistic_data_entity.dart';

class ReviewStatisticEntity {
  final int reviewCountTotal;
  final List<ReviewStatisticDataEntity> statistics;

  const ReviewStatisticEntity({
    required this.reviewCountTotal,
    required this.statistics,
  });

  factory ReviewStatisticEntity.fromModel(ReviewStatisticModel model) {
    return ReviewStatisticEntity(
      reviewCountTotal: model.reviewCountTotal,
      statistics: model.statistics
          .map((e) => ReviewStatisticDataEntity.fromModel(e))
          .toList(),
    );
  }
}
