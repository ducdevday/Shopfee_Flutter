// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'size_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SizeModel _$SizeModelFromJson(Map<String, dynamic> json) => SizeModel(
      size: json['size'] as String?,
      price: (json['price'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$SizeModelToJson(SizeModel instance) => <String, dynamic>{
      'size': instance.size,
      'price': instance.price,
    };
