// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'receiver_information_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReceiverInformationModel _$ReceiverInformationModelFromJson(
        Map<String, dynamic> json) =>
    ReceiverInformationModel(
      userId: json['userId'] as String?,
      detail: json['detail'] as String?,
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
      note: json['note'] as String?,
      recipientName: json['recipientName'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      receiveTime: json['receiveTime'] == null
          ? null
          : DateTime.parse(json['receiveTime'] as String),
    );

Map<String, dynamic> _$ReceiverInformationModelToJson(
        ReceiverInformationModel instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'detail': instance.detail,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'note': instance.note,
      'recipientName': instance.recipientName,
      'phoneNumber': instance.phoneNumber,
      'receiveTime': instance.receiveTime?.toIso8601String(),
    };
