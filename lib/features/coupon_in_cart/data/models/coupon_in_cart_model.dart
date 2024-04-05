import 'package:json_annotation/json_annotation.dart';
import 'package:shopfee/core/common/enum/coupon_type.dart';
import 'package:shopfee/features/coupon_in_cart/data/models/coupon_information_model.dart';

part 'coupon_in_cart_model.g.dart';

@JsonSerializable()
class CouponInCartModel {
  final List<CouponType>? noShippingWithCoupon;
  final List<CouponInformationModel>? shippingCouponList;
  final List<CouponType>? noOrderWithCoupon;
  final List<CouponInformationModel>? orderCouponList;
  final List<CouponType>? noProductWithCoupon;
  final List<CouponInformationModel>? productCouponList;

  const CouponInCartModel({
    this.noShippingWithCoupon,
    this.shippingCouponList,
    this.noOrderWithCoupon,
    this.orderCouponList,
    this.noProductWithCoupon,
    this.productCouponList,
  });

  factory CouponInCartModel.fromJson(Map<String, dynamic> json) {
    return _$CouponInCartModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$CouponInCartModelToJson(this);
  }
}
