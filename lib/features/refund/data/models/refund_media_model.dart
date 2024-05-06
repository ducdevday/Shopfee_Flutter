
import 'package:json_annotation/json_annotation.dart';

part 'refund_media_model.g.dart';

@JsonSerializable()
class RefundMediaModel{
  final String? thumbnailUrl;
  final String? mediaUrl;

  const RefundMediaModel({
    this.thumbnailUrl,
    this.mediaUrl,
  });

  factory RefundMediaModel.fromJson(Map<String, dynamic> json) {
    return _$RefundMediaModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$RefundMediaModelToJson(this);
  }
}