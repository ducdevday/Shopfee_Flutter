import 'package:shopfee/features/coupon_in_cart/data/models/product_reward_model.dart';

class ProductRewardEntity {
  final String? id;
  final String? name;
  final String? size;
  final int? quantity;

  const ProductRewardEntity({
    this.id,
    this.name,
    this.size,
    this.quantity,
  });

  factory ProductRewardEntity.fromModel(ProductRewardModel model) {
    return ProductRewardEntity(
      id: model.id,
      name: model.name,
      size: model.size,
      quantity: model.quantity,
    );
  }
//
}
