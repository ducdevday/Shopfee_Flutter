import 'package:shopfee/core/common/enum/coupon_type.dart';
import 'package:shopfee/features/coupon_in_cart/data/models/coupon_in_cart_model.dart';
import 'package:shopfee/features/coupon_in_cart/domain/entities/coupon_informaiton_entity.dart';

import 'combination_condition_entity.dart';

class CouponInCartEntity {
  final List<CouponType>? shippingNoCombineBy;
  final List<CouponInformationEntity>? shippingCouponList;
  final List<CouponType>? orderNoCombineBy;
  final List<CouponInformationEntity>? orderCouponList;
  final List<CouponType>? productNoCombineBy;
  final List<CouponInformationEntity>? productCouponList;

  const CouponInCartEntity({
    required this.shippingNoCombineBy,
    this.shippingCouponList,
    required this.orderNoCombineBy,
    this.orderCouponList,
    required this.productNoCombineBy,
    this.productCouponList,
  });

  factory CouponInCartEntity.fromModel(CouponInCartModel model) {
    final shippingNoCombineBy = model.shippingNoCombineBy;
    var shippingCouponListModel = model.shippingCouponList
        ?.map((e) => CouponInformationEntity.fromModel(e))
        .toList();
    if (shippingNoCombineBy != null && shippingNoCombineBy.isNotEmpty) {
      final List<CombinationConditionEntity>? combinationConditionList;
      combinationConditionList = shippingNoCombineBy.map((e) => CombinationConditionEntity(type: e)).toList();
      shippingCouponListModel = shippingCouponListModel!
          .map((e) => e.copyWith(valid: false, combinationConditionList: combinationConditionList))
          .toList();
    }
    final orderNoCombineBy = model.orderNoCombineBy;
    var orderCouponListModel = model.orderCouponList
        ?.map((e) => CouponInformationEntity.fromModel(e))
        .toList();
    if (orderNoCombineBy != null && orderNoCombineBy.isNotEmpty) {
      final List<CombinationConditionEntity>? combinationConditionList;
      combinationConditionList = orderNoCombineBy.map((e) => CombinationConditionEntity(type: e)).toList();
      orderCouponListModel =
          orderCouponListModel!.map((e) => e.copyWith(valid: false, combinationConditionList: combinationConditionList)).toList();
    }
    final productNoCombineBy = model.productNoCombineBy;
    var productCouponListModel = model.productCouponList
        ?.map((e) => CouponInformationEntity.fromModel(e))
        .toList();
    if (productNoCombineBy != null && productNoCombineBy.isNotEmpty) {
      final List<CombinationConditionEntity>? combinationConditionList;
      combinationConditionList = productNoCombineBy.map((e) => CombinationConditionEntity(type: e)).toList();
      productCouponListModel =
          productCouponListModel!.map((e) => e.copyWith(valid: false)).toList();
    }

    return CouponInCartEntity(
      shippingNoCombineBy: shippingNoCombineBy,
      shippingCouponList: shippingCouponListModel,
      orderNoCombineBy: orderNoCombineBy,
      orderCouponList: orderCouponListModel,
      productNoCombineBy: productNoCombineBy,
      productCouponList: productCouponListModel,
    );
  }
}
