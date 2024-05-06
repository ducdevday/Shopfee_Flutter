import 'package:shopfee/features/coupon_in_cart/data/models/product_reward_model.dart';
import 'package:shopfee/features/coupon_in_cart/domain/entities/product_reward_entity.dart';
import 'package:shopfee/features/receipt/data/models/discount_information_model.dart';

class DiscountInformationEntity {
  final double? orderDiscount;
  final double? shippingDiscount;
  final List<ProductRewardEntity>? productGiftList;

  const DiscountInformationEntity({
    this.orderDiscount,
    this.shippingDiscount,
    this.productGiftList,
  });

  factory DiscountInformationEntity.fromModel(DiscountInformationModel model) {
    return DiscountInformationEntity(
      orderDiscount: model.orderDiscount,
      shippingDiscount: model.shippingDiscount,
      productGiftList: model.productGiftList
          ?.map((e) => ProductRewardEntity.fromModel(e))
          .toList(),
    );
  }

}
