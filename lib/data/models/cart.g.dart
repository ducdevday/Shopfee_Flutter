// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Cart _$CartFromJson(Map<String, dynamic> json) => Cart(
      orders: (json['orders'] as List<dynamic>?)
              ?.map((e) => Order.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <Order>[],
      typeDelivery:
          $enumDecodeNullable(_$TypeDeliveryEnumMap, json['typeDelivery']),
      address: json['address'] == null
          ? null
          : Address.fromJson(json['address'] as Map<String, dynamic>),
      note: json['note'] as String?,
      deliveryTime: json['deliveryTime'] == null
          ? null
          : DateTime.parse(json['deliveryTime'] as String),
      typePayment:
          $enumDecodeNullable(_$TypePaymentEnumMap, json['typePayment']) ??
              TypePayment.CASHING,
      voucher: json['voucher'] == null
          ? null
          : Voucher.fromJson(json['voucher'] as Map<String, dynamic>),
      shippingFee: (json['shippingFee'] as num?)?.toDouble() ?? 18000,
    );

Map<String, dynamic> _$CartToJson(Cart instance) => <String, dynamic>{
      'orders': instance.orders,
      'typeDelivery': instance.typeDelivery,
      'address': instance.address,
      'note': instance.note,
      'deliveryTime': instance.deliveryTime?.toIso8601String(),
      'typePayment': instance.typePayment,
      'voucher': instance.voucher,
      'shippingFee': instance.shippingFee,
    };

const _$TypeDeliveryEnumMap = {
  TypeDelivery.TakeAway: 'TakeAway',
  TypeDelivery.HomeDelivery: 'HomeDelivery',
};

const _$TypePaymentEnumMap = {
  TypePayment.CASHING: 'CASHING',
  TypePayment.BANKING: 'BANKING',
};
