// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CartModel _$CartModelFromJson(Map<String, dynamic> json) => CartModel(
      orders: (json['orders'] as List<dynamic>)
          .map((e) => OrderModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      orderType: $enumDecodeNullable(_$OrderTypeEnumMap, json['orderType']),
      address: json['address'] == null
          ? null
          : AddressModel.fromJson(json['address'] as Map<String, dynamic>),
      note: json['note'] as String?,
      receiveTime: json['receiveTime'] == null
          ? null
          : DateTime.parse(json['receiveTime'] as String),
      paymentType:
          $enumDecodeNullable(_$PaymentTypeEnumMap, json['paymentType']),
      shippingFee: (json['shippingFee'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$CartModelToJson(CartModel instance) => <String, dynamic>{
      'orders': instance.orders,
      'orderType': instance.orderType,
      'address': instance.address,
      'note': instance.note,
      'receiveTime': instance.receiveTime?.toIso8601String(),
      'paymentType': instance.paymentType,
      'shippingFee': instance.shippingFee,
    };

const _$OrderTypeEnumMap = {
  OrderType.SHIPPING: 'SHIPPING',
  OrderType.ONSITE: 'ONSITE',
};

const _$PaymentTypeEnumMap = {
  PaymentType.CASHING: 'CASHING',
  PaymentType.BANKING_VNPAY: 'BANKING_VNPAY',
};
