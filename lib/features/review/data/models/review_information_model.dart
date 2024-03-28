import 'package:json_annotation/json_annotation.dart';
import 'package:shopfee/features/review/data/models/review_model.dart';

part 'review_information_model.g.dart';

@JsonSerializable()
class ReviewInformationModel {
  final String? id;
  final String? name;
  final String? thumbnailUrl;
  final ReviewModel? review;

  const ReviewInformationModel({
    this.id,
    this.name,
    this.thumbnailUrl,
    this.review,
  });

  factory ReviewInformationModel.fromJson(Map<String, dynamic> json) {
    return _$ReviewInformationModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$ReviewInformationModelToJson(this);
  }
}
