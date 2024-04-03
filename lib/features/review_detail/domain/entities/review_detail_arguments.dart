import 'package:shopfee/features/home/domain/entities/rating_summary_entity.dart';

class ReviewDetailArguments{
  final String productId;
  final RatingSummaryEntity ratingSummary;

  const ReviewDetailArguments({
    required this.productId,
    required this.ratingSummary,
  });
}