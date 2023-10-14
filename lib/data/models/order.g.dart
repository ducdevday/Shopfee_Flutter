// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Order _$OrderFromJson(Map<String, dynamic> json) => Order(
      product: Product.fromJson(json['product'] as Map<String, dynamic>),
      quantity: json['quantity'] as int? ?? 1,
      size: json['size'] == null
          ? null
          : SizeModel.fromJson(json['size'] as Map<String, dynamic>),
      toppings: (json['toppings'] as List<dynamic>?)
              ?.map((e) => Topping.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <Topping>[],
      note: json['note'] as String? ?? "",
    );

Map<String, dynamic> _$OrderToJson(Order instance) => <String, dynamic>{
      'product': instance.product,
      'quantity': instance.quantity,
      'size': instance.size,
      'toppings': instance.toppings,
      'note': instance.note,
    };
