// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'receipt_product_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReceiptProductModel _$ReceiptProductModelFromJson(Map<String, dynamic> json) =>
    ReceiptProductModel(
      id: json['id'] as String?,
      name: json['name'] as String?,
      quantity: json['quantity'] as int?,
      size: json['size'] as String?,
      price: (json['price'] as num?)?.toDouble(),
      toppings: (json['toppings'] as List<dynamic>?)
          ?.map((e) => ToppingModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      note: json['note'] as String?,
    );

Map<String, dynamic> _$ReceiptProductModelToJson(
        ReceiptProductModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'quantity': instance.quantity,
      'size': instance.size,
      'price': instance.price,
      'toppings': instance.toppings,
      'note': instance.note,
    };
