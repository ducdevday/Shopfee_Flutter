import 'package:json_annotation/json_annotation.dart';
import 'package:shopfee/features/product_detail/domain/entities/order_entity.dart';

import 'product_detail_model.dart';
import 'size_model.dart';
import 'topping_model.dart';

part "order_model.g.dart";

@JsonSerializable()
class OrderModel {
  final ProductDetailModel product;
  final int quantity;
  final SizeModel? size;
  final List<ToppingModel> toppings;
  final String note;

  const OrderModel({
    required this.product,
    required this.quantity,
    this.size,
    required this.toppings,
    required this.note,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return _$OrderModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$OrderModelToJson(this);
  }

  Map<String, dynamic> toJsonOrder() {
    return {
      'productId': this.product.id,
      'quantity': this.quantity,
      'toppings': this.toppings.map((topping) => topping.toJson()).toList(),
      'price': this.size!.price,
      'size': this.size!.size,
      'note': this.note,
    };
  }

  factory OrderModel.fromEntity(OrderEntity entity) {
    return OrderModel(
      product: ProductDetailModel.fromEntity(entity.product),
      quantity: entity.quantity,
      size: entity.size == null ? null : SizeModel.fromEntity(entity.size!),
      toppings: entity.toppings.map((e) => ToppingModel.fromEntity(e)).toList(),
      note: entity.note,
    );
  }
}
