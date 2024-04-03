// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderModel _$OrderModelFromJson(Map<String, dynamic> json) => OrderModel(
      product:
          ProductDetailModel.fromJson(json['product'] as Map<String, dynamic>),
      quantity: json['quantity'] as int,
      size: json['size'] == null
          ? null
          : SizeModel.fromJson(json['size'] as Map<String, dynamic>),
      toppings: (json['toppings'] as List<dynamic>)
          .map((e) => ToppingModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      note: json['note'] as String,
    );

Map<String, dynamic> _$OrderModelToJson(OrderModel instance) =>
    <String, dynamic>{
      'product': instance.product,
      'quantity': instance.quantity,
      'size': instance.size,
      'toppings': instance.toppings,
      'note': instance.note,
    };
