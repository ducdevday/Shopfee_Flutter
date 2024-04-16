import 'package:shopfee/core/common/enum/media_type.dart';
import 'package:shopfee/features/refund/data/models/refund_media_model.dart';

class RefundMediaEntity {
  final String? url;
  final MediaType mediaType;

  const RefundMediaEntity({
    this.url,
    required this.mediaType,
  });

  factory RefundMediaEntity.fromModel(RefundMediaModel model) {
    if (model.thumbnailUrl != null && model.thumbnailUrl != "") {
      return RefundMediaEntity(
        url: model.thumbnailUrl,
        mediaType: MediaType.VIDEO,
      );
    } else {
      return RefundMediaEntity(
        url: model.mediaUrl,
        mediaType: MediaType.IMAGE,
      );
    }
  }
}
