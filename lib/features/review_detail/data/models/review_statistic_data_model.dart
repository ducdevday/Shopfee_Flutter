
import 'package:json_annotation/json_annotation.dart';

part 'review_statistic_data_model.g.dart';

@JsonSerializable()
class ReviewStatisticDataModel{
  final int star;
  final int count;

  const ReviewStatisticDataModel({
    required this.star,
    required this.count,
  });

  factory ReviewStatisticDataModel.fromJson(Map<String, dynamic> json) {
    return _$ReviewStatisticDataModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$ReviewStatisticDataModelToJson(this);
  }
}