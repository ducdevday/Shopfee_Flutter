// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'receipt_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReceiptModel _$ReceiptModelFromJson(Map<String, dynamic> json) => ReceiptModel(
      id: json['id'] as String?,
      note: json['note'] as String?,
      totalPayment: json['totalPayment'] as num?,
      shippingFee: json['shippingFee'] as num?,
      totalItemPrice: json['totalItemPrice'] as num?,
      orderType: $enumDecodeNullable(_$OrderTypeEnumMap, json['orderType']),
      receiverInformation: json['receiverInformation'] == null
          ? null
          : ReceiverInformationModel.fromJson(
              json['receiverInformation'] as Map<String, dynamic>),
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      itemList: (json['itemList'] as List<dynamic>?)
          ?.map((e) => ReceiptProductModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      discountInformation: json['rewardInformation'] == null
          ? null
          : DiscountInformationModel.fromJson(
              json['rewardInformation'] as Map<String, dynamic>),
      transaction: json['transaction'] == null
          ? null
          : TransactionModel.fromJson(
              json['transaction'] as Map<String, dynamic>),
      branch: json['branch'] == null
          ? null
          : BranchModel.fromJson(json['branch'] as Map<String, dynamic>),
      coin: (json['coin'] as num?)?.toInt(),
      needReview: json['needReview'] as bool?,
      refundRequestStatus: $enumDecodeNullable(
          _$RefundRequestStatusEnumMap, json['refundStatus']),
    );

Map<String, dynamic> _$ReceiptModelToJson(ReceiptModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'note': instance.note,
      'totalPayment': instance.totalPayment,
      'shippingFee': instance.shippingFee,
      'totalItemPrice': instance.totalItemPrice,
      'orderType': instance.orderType,
      'receiverInformation': instance.receiverInformation,
      'createdAt': instance.createdAt?.toIso8601String(),
      'itemList': instance.itemList,
      'rewardInformation': instance.discountInformation,
      'transaction': instance.transaction,
      'branch': instance.branch,
      'coin': instance.coin,
      'needReview': instance.needReview,
      'refundStatus':
          _$RefundRequestStatusEnumMap[instance.refundRequestStatus],
    };

const _$OrderTypeEnumMap = {
  OrderType.SHIPPING: 'SHIPPING',
  OrderType.ONSITE: 'ONSITE',
};

const _$RefundRequestStatusEnumMap = {
  RefundRequestStatus.CAN_REFUND: 'CAN_REFUND',
  RefundRequestStatus.REFUNDED: 'REFUNDED',
  RefundRequestStatus.NOT_REFUND: 'NOT_REFUND',
};
