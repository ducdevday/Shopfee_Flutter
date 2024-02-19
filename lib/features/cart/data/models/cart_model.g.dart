// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CartModel _$CartModelFromJson(Map<String, dynamic> json) => CartModel(
      orders: (json['orders'] as List<dynamic>)
          .map((e) => OrderModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      typeDelivery:
          $enumDecodeNullable(_$DeliveryTypeEnumMap, json['typeDelivery']),
      address: json['address'] == null
          ? null
          : AddressModel.fromJson(json['address'] as Map<String, dynamic>),
      note: json['note'] as String?,
      deliveryTime: json['deliveryTime'] == null
          ? null
          : DateTime.parse(json['deliveryTime'] as String),
      typePayment:
          $enumDecodeNullable(_$PaymentTypeEnumMap, json['typePayment']),
      shippingFee: (json['shippingFee'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$CartModelToJson(CartModel instance) => <String, dynamic>{
      'orders': instance.orders,
      'typeDelivery': instance.typeDelivery,
      'address': instance.address,
      'note': instance.note,
      'deliveryTime': instance.deliveryTime?.toIso8601String(),
      'typePayment': instance.typePayment,
      'shippingFee': instance.shippingFee,
    };

const _$DeliveryTypeEnumMap = {
  DeliveryType.TakeAway: 'TakeAway',
  DeliveryType.HomeDelivery: 'HomeDelivery',
};

const _$PaymentTypeEnumMap = {
  PaymentType.CASHING: 'CASHING',
  PaymentType.BANKING: 'BANKING',
};
