// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'receipt.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Receipt _$ReceiptFromJson(Map<String, dynamic> json) => Receipt(
      id: json['id'] as String?,
      note: json['note'] as String?,
      total: (json['total'] as num?)?.toDouble(),
      orderType: $enumDecodeNullable(_$OrderTypeEnumMap, json['orderType']),
      address: json['address'] == null
          ? null
          : Address.fromJson(json['address'] as Map<String, dynamic>),
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      products: (json['products'] as List<dynamic>?)
          ?.map((e) => ReceiptProduct.fromJson(e as Map<String, dynamic>))
          .toList(),
      transaction: json['transaction'] == null
          ? null
          : Transaction.fromJson(json['transaction'] as Map<String, dynamic>),
      review: json['review'] == null
          ? null
          : Review.fromJson(json['review'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ReceiptToJson(Receipt instance) => <String, dynamic>{
      'id': instance.id,
      'note': instance.note,
      'total': instance.total,
      'orderType': instance.orderType,
      'address': instance.address,
      'createdAt': instance.createdAt?.toIso8601String(),
      'products': instance.products,
      'transaction': instance.transaction,
      'review': instance.review,
    };

const _$OrderTypeEnumMap = {
  OrderType.SHIPPING: 'SHIPPING',
  OrderType.ONSITE: 'ONSITE',
};
