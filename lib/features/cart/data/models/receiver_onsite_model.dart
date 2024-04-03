import 'package:json_annotation/json_annotation.dart';
import 'package:shopfee/features/cart/domain/entities/receiver_onsite_entity.dart';

part 'receiver_onsite_model.g.dart';

@JsonSerializable()
class ReceiverOnsiteModel {
  final String? recipientName;
  final String? phoneNumber;

  const ReceiverOnsiteModel({
    this.recipientName,
    this.phoneNumber,
  });

  factory ReceiverOnsiteModel.fromJson(Map<String, dynamic> json) {
    return _$ReceiverOnsiteModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$ReceiverOnsiteModelToJson(this);
  }

  factory ReceiverOnsiteModel.fromEntity(
      ReceiverOnsiteEntity entity) {
    return ReceiverOnsiteModel(
        recipientName: entity.recipientName, phoneNumber: entity.phoneNumber);
  }
//
}
