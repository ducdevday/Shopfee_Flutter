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
      store: json['store'] == null
          ? null
          : StoreDetailModel.fromJson(json['store'] as Map<String, dynamic>),
      receiveTime: json['receiveTime'] == null
          ? null
          : DateTime.parse(json['receiveTime'] as String),
      paymentType:
          $enumDecodeNullable(_$PaymentTypeEnumMap, json['paymentType']),
      shippingFee: (json['shippingFee'] as num?)?.toDouble(),
      coin: json['coin'] as num?,
    );

Map<String, dynamic> _$CartModelToJson(CartModel instance) => <String, dynamic>{
      'orders': instance.orders,
      'orderType': instance.orderType,
      'address': instance.address,
      'note': instance.note,
      'store': instance.store,
      'receiveTime': instance.receiveTime?.toIso8601String(),
      'paymentType': instance.paymentType,
      'shippingFee': instance.shippingFee,
      'coin': instance.coin,
    };

const _$OrderTypeEnumMap = {
  OrderType.SHIPPING: 'SHIPPING',
  OrderType.ONSITE: 'ONSITE',
};

const _$PaymentTypeEnumMap = {
  PaymentType.CASHING: 'CASHING',
  PaymentType.VNPAY: 'VNPAY',
  PaymentType.ZALOPAY: 'ZALOPAY',
};
