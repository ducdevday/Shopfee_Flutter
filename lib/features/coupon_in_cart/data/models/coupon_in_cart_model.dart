import 'package:json_annotation/json_annotation.dart';
import 'package:shopfee/features/coupon_in_cart/data/models/coupon_information_model.dart';

part 'coupon_in_cart_model.g.dart';

@JsonSerializable()
class CouponInCartModel {
  final bool? canCombinedWithShippingCoupon;
  final List<CouponInformationModel>? shippingCouponList;
  final bool? canCombinedWithOrderCoupon;
  final List<CouponInformationModel>? orderCouponList;
  final bool? canCombinedWithProductCoupon;
  final List<CouponInformationModel>? productCouponList;

  const CouponInCartModel({
    this.canCombinedWithShippingCoupon,
    this.shippingCouponList,
    this.canCombinedWithOrderCoupon,
    this.orderCouponList,
    this.canCombinedWithProductCoupon,
    this.productCouponList,
  });

  factory CouponInCartModel.fromJson(Map<String, dynamic> json) {
    return _$CouponInCartModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$CouponInCartModelToJson(this);
  }
}
