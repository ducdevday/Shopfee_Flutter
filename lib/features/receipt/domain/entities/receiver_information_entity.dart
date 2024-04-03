import 'package:shopfee/features/receipt/data/models/receiver_information_model.dart';

class ReceiverInformationEntity {
  final String? userId;
  final String? detail;
  final double? latitude;
  final double? longitude;
  final String? note;
  final String? recipientName;
  final String? phoneNumber;
  final DateTime? receiveTime;

  const ReceiverInformationEntity({
    this.userId,
    this.detail,
    this.latitude,
    this.longitude,
    this.note,
    this.recipientName,
    this.phoneNumber,
    this.receiveTime,
  });

  factory ReceiverInformationEntity.fromModel(ReceiverInformationModel model) {
    return ReceiverInformationEntity(
      userId: model.userId,
      detail: model.detail,
      latitude: model.latitude,
      longitude: model.longitude,
      note: model.note,
      recipientName: model.recipientName,
      phoneNumber: model.phoneNumber,
      receiveTime: model.receiveTime,
    );
  }
//
}