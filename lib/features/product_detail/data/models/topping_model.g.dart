// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'topping_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ToppingModel _$ToppingModelFromJson(Map<String, dynamic> json) => ToppingModel(
      name: json['name'] as String?,
      price: (json['price'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$ToppingModelToJson(ToppingModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'price': instance.price,
    };
