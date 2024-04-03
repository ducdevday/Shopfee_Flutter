import 'package:json_annotation/json_annotation.dart';

part 'receiver_information_model.g.dart';

@JsonSerializable()
class ReceiverInformationModel {
  final String? userId;
  final String? detail;
  final double? latitude;
  final double? longitude;
  final String? note;
  final String? recipientName;
  final String? phoneNumber;
  final DateTime? receiveTime;

  const ReceiverInformationModel({
    this.userId,
    this.detail,
    this.latitude,
    this.longitude,
    this.note,
    this.recipientName,
    this.phoneNumber,
    this.receiveTime,
  });

  factory ReceiverInformationModel.fromJson(Map<String, dynamic> json) {
    return _$ReceiverInformationModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$ReceiverInformationModelToJson(this);
  }
}
