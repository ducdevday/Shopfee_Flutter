// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coupon_in_cart_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CouponInCartModel _$CouponInCartModelFromJson(Map<String, dynamic> json) =>
    CouponInCartModel(
      canCombinedWithShippingCoupon:
          json['canCombinedWithShippingCoupon'] as bool?,
      shippingCouponList: (json['shippingCouponList'] as List<dynamic>?)
          ?.map(
              (e) => CouponInformationModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      canCombinedWithOrderCoupon: json['canCombinedWithOrderCoupon'] as bool?,
      orderCouponList: (json['orderCouponList'] as List<dynamic>?)
          ?.map(
              (e) => CouponInformationModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      canCombinedWithProductCoupon:
          json['canCombinedWithProductCoupon'] as bool?,
      productCouponList: (json['productCouponList'] as List<dynamic>?)
          ?.map(
              (e) => CouponInformationModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CouponInCartModelToJson(CouponInCartModel instance) =>
    <String, dynamic>{
      'canCombinedWithShippingCoupon': instance.canCombinedWithShippingCoupon,
      'shippingCouponList': instance.shippingCouponList,
      'canCombinedWithOrderCoupon': instance.canCombinedWithOrderCoupon,
      'orderCouponList': instance.orderCouponList,
      'canCombinedWithProductCoupon': instance.canCombinedWithProductCoupon,
      'productCouponList': instance.productCouponList,
    };
