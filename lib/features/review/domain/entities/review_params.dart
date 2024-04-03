import 'package:json_annotation/json_annotation.dart';

part 'review_params.g.dart';

@JsonSerializable()
class ReviewParams{
  final String orderItemId;
  final int star;
  final String content;

  const ReviewParams({
    required this.orderItemId,
    required this.star,
    required this.content,
  });

  factory ReviewParams.fromJson(Map<String, dynamic> json) {
    return _$ReviewParamsFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$ReviewParamsToJson(this);
  }
}