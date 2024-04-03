import 'package:json_annotation/json_annotation.dart';
import 'package:shopfee/features/home/domain/entities/rating_summary_entity.dart';

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

  factory RatingSummaryModel.fromEntity(RatingSummaryEntity entity) {
    return RatingSummaryModel(star: entity.star, quantity: entity.quantity);
  }
}
