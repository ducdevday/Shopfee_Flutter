import 'package:shopfee/features/cart/data/models/receiver_onsite_model.dart';

class ReceiverOnsiteEntity {
  final String? recipientName;
  final String? phoneNumber;

  const ReceiverOnsiteEntity({
    this.recipientName,
    this.phoneNumber,
  });

  factory ReceiverOnsiteEntity.fromModel(ReceiverOnsiteModel model) {
    return ReceiverOnsiteEntity(
        recipientName: model.recipientName, phoneNumber: model.phoneNumber);
  }
}
