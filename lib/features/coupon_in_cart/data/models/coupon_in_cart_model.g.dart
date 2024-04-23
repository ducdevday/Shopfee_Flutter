// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coupon_in_cart_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CouponInCartModel _$CouponInCartModelFromJson(Map<String, dynamic> json) =>
    CouponInCartModel(
      shippingNoCombineBy: (json['shippingNoCombineBy'] as List<dynamic>?)
          ?.map((e) => $enumDecode(_$CouponTypeEnumMap, e))
          .toList(),
      shippingCouponList: (json['shippingCouponList'] as List<dynamic>?)
          ?.map(
              (e) => CouponInformationModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      orderNoCombineBy: (json['orderNoCombineBy'] as List<dynamic>?)
          ?.map((e) => $enumDecode(_$CouponTypeEnumMap, e))
          .toList(),
      orderCouponList: (json['orderCouponList'] as List<dynamic>?)
          ?.map(
              (e) => CouponInformationModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      productNoCombineBy: (json['productNoCombineBy'] as List<dynamic>?)
          ?.map((e) => $enumDecode(_$CouponTypeEnumMap, e))
          .toList(),
      productCouponList: (json['productCouponList'] as List<dynamic>?)
          ?.map(
              (e) => CouponInformationModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CouponInCartModelToJson(CouponInCartModel instance) =>
    <String, dynamic>{
      'shippingNoCombineBy': instance.shippingNoCombineBy
          ?.map((e) => _$CouponTypeEnumMap[e]!)
          .toList(),
      'shippingCouponList': instance.shippingCouponList,
      'orderNoCombineBy': instance.orderNoCombineBy
          ?.map((e) => _$CouponTypeEnumMap[e]!)
          .toList(),
      'orderCouponList': instance.orderCouponList,
      'productNoCombineBy': instance.productNoCombineBy
          ?.map((e) => _$CouponTypeEnumMap[e]!)
          .toList(),
      'productCouponList': instance.productCouponList,
    };

const _$CouponTypeEnumMap = {
  CouponType.SHIPPING: 'SHIPPING',
  CouponType.ORDER: 'ORDER',
  CouponType.PRODUCT: 'PRODUCT',
};
