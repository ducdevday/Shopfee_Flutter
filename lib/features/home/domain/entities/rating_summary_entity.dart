import 'package:shopfee/features/home/data/models/rating_summary_model.dart';

class RatingSummaryEntity {
  final num? star;
  final num? quantity;

  const RatingSummaryEntity({
    this.star,
    this.quantity,
  });

  factory RatingSummaryEntity.fromModel(RatingSummaryModel model) {
    return RatingSummaryEntity(star: model.star, quantity: model.quantity);
  }
}
