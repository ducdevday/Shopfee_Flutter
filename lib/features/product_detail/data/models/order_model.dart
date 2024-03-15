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

  double get total =>
      quantity * size!.price! +
          quantity * toppings.fold(0, (total, current) => total + current.price!);

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return _$OrderModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$OrderModelToJson(this);
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
