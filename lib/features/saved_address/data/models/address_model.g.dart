// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddressModel _$AddressModelFromJson(Map<String, dynamic> json) => AddressModel(
      id: json['id'] as String?,
      details: json['details'] as String?,
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
      note: json['note'] as String?,
      recipientName: json['recipientName'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      userId: json['userId'] as String?,
      isDefault: json['default'] as bool? ?? false,
    );

Map<String, dynamic> _$AddressModelToJson(AddressModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'details': instance.details,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'note': instance.note,
      'recipientName': instance.recipientName,
      'phoneNumber': instance.phoneNumber,
      'userId': instance.userId,
      'default': instance.isDefault,
    };
