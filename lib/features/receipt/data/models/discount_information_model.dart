import 'package:json_annotation/json_annotation.dart';
import 'package:shopfee/features/coupon_in_cart/data/models/product_reward_model.dart';

part "discount_information_model.g.dart";

@JsonSerializable()
class DiscountInformationModel {
  final double? orderDiscount;
  final double? shippingDiscount;
  final List<ProductRewardModel>? productGiftList;

  const DiscountInformationModel({
    this.orderDiscount,
    this.shippingDiscount,
    this.productGiftList,
  });

  factory DiscountInformationModel.fromJson(Map<String, dynamic> json) {
    return _$DiscountInformationModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$DiscountInformationModelToJson(this);
  }
}
