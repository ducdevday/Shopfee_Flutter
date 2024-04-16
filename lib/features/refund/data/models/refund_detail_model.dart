import 'package:json_annotation/json_annotation.dart';
import 'package:shopfee/core/common/enum/refund_status.dart';
import 'package:shopfee/features/refund/data/models/refund_media_model.dart';

part 'refund_detail_model.g.dart';

@JsonSerializable()
class RefundDetailModel{
  final String? reason;
  final String? note;
  final RefundStatus status;
  final List<RefundMediaModel>? mediaList;

  const RefundDetailModel({
    this.reason,
    this.note,
    required this.status,
    this.mediaList,
  });

  factory RefundDetailModel.fromJson(Map<String, dynamic> json) {
    return _$RefundDetailModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$RefundDetailModelToJson(this);
  }
}