import 'package:shopfee/core/common/enum/coupon_type.dart';
import 'package:shopfee/features/coupon_in_cart/data/models/coupon_in_cart_model.dart';
import 'package:shopfee/features/coupon_in_cart/domain/entities/coupon_informaiton_entity.dart';

class CouponInCartEntity {
  final List<CouponType>? noShippingWithCoupon;
  final List<CouponInformationEntity>? shippingCouponList;
  final List<CouponType>? noOrderWithCoupon;
  final List<CouponInformationEntity>? orderCouponList;
  final List<CouponType>? noProductWithCoupon;
  final List<CouponInformationEntity>? productCouponList;

  const CouponInCartEntity({
    required this.noShippingWithCoupon,
    this.shippingCouponList,
    required this.noOrderWithCoupon,
    this.orderCouponList,
    required this.noProductWithCoupon,
    this.productCouponList,
  });

  factory CouponInCartEntity.fromModel(CouponInCartModel model) {
    return CouponInCartEntity(
      noShippingWithCoupon: model.noShippingWithCoupon,
      shippingCouponList: model.shippingCouponList
          ?.map((e) => CouponInformationEntity.fromModel(e))
          .toList(),
      noOrderWithCoupon: model.noOrderWithCoupon,
      orderCouponList: model.orderCouponList
          ?.map((e) => CouponInformationEntity.fromModel(e))
          .toList(),
      noProductWithCoupon: model.noProductWithCoupon,
      productCouponList: model.productCouponList
          ?.map((e) => CouponInformationEntity.fromModel(e))
          .toList(),
    );
  }
}
