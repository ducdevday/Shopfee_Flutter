// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coupon_in_cart_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CouponInCartModel _$CouponInCartModelFromJson(Map<String, dynamic> json) =>
    CouponInCartModel(
      noShippingWithCoupon: (json['noShippingWithCoupon'] as List<dynamic>?)
          ?.map((e) => $enumDecode(_$CouponTypeEnumMap, e))
          .toList(),
      shippingCouponList: (json['shippingCouponList'] as List<dynamic>?)
          ?.map(
              (e) => CouponInformationModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      noOrderWithCoupon: (json['noOrderWithCoupon'] as List<dynamic>?)
          ?.map((e) => $enumDecode(_$CouponTypeEnumMap, e))
          .toList(),
      orderCouponList: (json['orderCouponList'] as List<dynamic>?)
          ?.map(
              (e) => CouponInformationModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      noProductWithCoupon: (json['noProductWithCoupon'] as List<dynamic>?)
          ?.map((e) => $enumDecode(_$CouponTypeEnumMap, e))
          .toList(),
      productCouponList: (json['productCouponList'] as List<dynamic>?)
          ?.map(
              (e) => CouponInformationModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CouponInCartModelToJson(CouponInCartModel instance) =>
    <String, dynamic>{
      'noShippingWithCoupon': instance.noShippingWithCoupon
          ?.map((e) => _$CouponTypeEnumMap[e]!)
          .toList(),
      'shippingCouponList': instance.shippingCouponList,
      'noOrderWithCoupon': instance.noOrderWithCoupon
          ?.map((e) => _$CouponTypeEnumMap[e]!)
          .toList(),
      'orderCouponList': instance.orderCouponList,
      'noProductWithCoupon': instance.noProductWithCoupon
          ?.map((e) => _$CouponTypeEnumMap[e]!)
          .toList(),
      'productCouponList': instance.productCouponList,
    };

const _$CouponTypeEnumMap = {
  CouponType.SHIPPING: 'SHIPPING',
  CouponType.ORDER: 'ORDER',
  CouponType.PRODUCT: 'PRODUCT',
};
