import 'package:shopfee/core/common/enum/refund_status.dart';
import 'package:shopfee/features/refund/data/models/refund_detail_model.dart';
import 'package:shopfee/features/refund/domain/entities/refund_media_model.dart';

class RefundDetailEntity {
  final String? reason;
  final String? note;
  final RefundStatus status;
  final List<RefundMediaEntity>? mediaList;

  const RefundDetailEntity({
    this.reason,
    this.note,
    required this.status,
    this.mediaList,
  });

  factory RefundDetailEntity.fromModel(RefundDetailModel model) {
    return RefundDetailEntity(
      reason: model.reason,
      note: model.note,
      status: model.status,
      mediaList:
          model.mediaList?.map((e) => RefundMediaEntity.fromModel(e)).toList(),
    );
  }
}
