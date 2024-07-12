import 'package:json_annotation/json_annotation.dart';
import 'package:shopfee/features/review_detail/data/models/review_statistic_data_model.dart';

part 'review_statistic_model.g.dart';

@JsonSerializable()
class ReviewStatisticModel {
  final int reviewCountTotal;
  final List<ReviewStatisticDataModel> statistics;

  const ReviewStatisticModel({
    required this.reviewCountTotal,
    required this.statistics,
  });

  factory ReviewStatisticModel.fromJson(Map<String, dynamic> json) {
    return _$ReviewStatisticModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$ReviewStatisticModelToJson(this);
  }
}
