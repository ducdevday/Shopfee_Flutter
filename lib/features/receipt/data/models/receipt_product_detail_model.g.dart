// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'receipt_product_detail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReceiptProductDetailModel _$ReceiptProductDetailModelFromJson(
        Map<String, dynamic> json) =>
    ReceiptProductDetailModel(
      quantity: json['quantity'] as int?,
      size: json['size'] as String?,
      price: (json['price'] as num?)?.toDouble(),
      toppings: (json['toppingList'] as List<dynamic>?)
          ?.map((e) => ToppingModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      note: json['note'] as String?,
    );

Map<String, dynamic> _$ReceiptProductDetailModelToJson(
        ReceiptProductDetailModel instance) =>
    <String, dynamic>{
      'quantity': instance.quantity,
      'size': instance.size,
      'price': instance.price,
      'toppingList': instance.toppings,
      'note': instance.note,
    };
