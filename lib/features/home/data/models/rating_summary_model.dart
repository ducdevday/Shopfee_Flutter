import 'package:json_annotation/json_annotation.dart';

part 'rating_summary_model.g.dart';

@JsonSerializable()
class RatingSummaryModel {
  final num? star;
  final num? quantity;

  const RatingSummaryModel({
    this.star,
    this.quantity,
  });

  factory RatingSummaryModel.fromJson(Map<String, dynamic> json) {
    return _$RatingSummaryModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$RatingSummaryModelToJson(this);
  }
}
