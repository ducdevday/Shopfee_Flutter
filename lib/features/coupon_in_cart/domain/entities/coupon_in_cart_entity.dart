import 'package:shopfee/features/coupon_in_cart/data/models/coupon_in_cart_model.dart';
import 'package:shopfee/features/coupon_in_cart/domain/entities/coupon_informaiton_entity.dart';

class CouponInCartEntity {
  final bool? canCombinedWithShippingCoupon;
  final List<CouponInformationEntity>? shippingCouponList;
  final bool? canCombinedWithOrderCoupon;
  final List<CouponInformationEntity>? orderCouponList;
  final bool? canCombinedWithProductCoupon;
  final List<CouponInformationEntity>? productCouponList;

  const CouponInCartEntity({
    this.canCombinedWithShippingCoupon,
    this.shippingCouponList,
    this.canCombinedWithOrderCoupon,
    this.orderCouponList,
    this.canCombinedWithProductCoupon,
    this.productCouponList,
  });

  factory CouponInCartEntity.fromModel(CouponInCartModel model) {
    return CouponInCartEntity(
      canCombinedWithShippingCoupon: model.canCombinedWithShippingCoupon,
      shippingCouponList: model.shippingCouponList
          ?.map((e) => CouponInformationEntity.fromModel(e))
          .toList(),
      canCombinedWithOrderCoupon: model.canCombinedWithOrderCoupon,
      orderCouponList: model.orderCouponList
          ?.map((e) => CouponInformationEntity.fromModel(e))
          .toList(),
      canCombinedWithProductCoupon: model.canCombinedWithProductCoupon,
      productCouponList: model.productCouponList
          ?.map((e) => CouponInformationEntity.fromModel(e))
          .toList(),
    );
  }

}
