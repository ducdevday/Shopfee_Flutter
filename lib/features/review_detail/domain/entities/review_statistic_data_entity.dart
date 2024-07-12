import 'package:shopfee/features/review_detail/data/models/review_statistic_data_model.dart';

class ReviewStatisticDataEntity{
  final int star;
  final int count;

  const ReviewStatisticDataEntity({
    required this.star,
    required this.count,
  });

  factory ReviewStatisticDataEntity.fromModel(ReviewStatisticDataModel model) {
    return ReviewStatisticDataEntity(
      star: model.star,
      count: model.count);
  }
}