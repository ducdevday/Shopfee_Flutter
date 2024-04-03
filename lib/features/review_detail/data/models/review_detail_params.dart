import 'package:json_annotation/json_annotation.dart';

part 'review_detail_params.g.dart';

@JsonSerializable()
class ReviewDetailParams {
  final int page;
  final int size;

  const ReviewDetailParams({
    required this.page,
    required this.size,
  });

  factory ReviewDetailParams.fromJson(Map<String, dynamic> json) {
    return _$ReviewDetailParamsFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$ReviewDetailParamsToJson(this);
  }
}
