import 'package:equatable/equatable.dart';
import 'package:shopfee/features/product_detail/data/models/order_model.dart';

import 'product_detail_entity.dart';
import 'size_entity.dart';
import 'topping_entity.dart';

class OrderEntity extends Equatable {
  final ProductDetailEntity product;
  final int quantity;
  final SizeEntity? size;
  final List<ToppingEntity> toppings;
  final String note;

  const OrderEntity(
      {required this.product,
      this.quantity = 1,
      this.size,
      this.toppings = const <ToppingEntity>[],
      this.note = ""});

  double get total =>
      quantity * size!.price +
      quantity * toppings.fold(0, (total, current) => total + current.price);

  double get totalSizePrice =>  quantity * size!.price;

  String get toppingOrderString {
    List<String> results = [];
    toppings.map((t) => t.name).forEach((name) {
      results.add(name);
    });
    return results.join(", ");
  }

  bool isEqualExceptQuantity(OrderEntity order) {
    if (product.id == order.product.id &&
        size == order.size &&
        areListsEqualUnordered(toppings.map((e)=>e.name).toList() ,order.toppings.map((e)=>e.name).toList()) &&
        note == order.note) {
      return true;
    }
    return false;
  }

  bool areListsEqualUnordered(List<String> list1, List<String> list2) {
    if (list1.length != list2.length) {
      return false;
    }

    List<String> sortedList1 = List.from(list1)..sort();
    List<String> sortedList2 = List.from(list2)..sort();

    for (int i = 0; i < sortedList1.length; i++) {
      if (sortedList1[i] != sortedList2[i]) {
        return false;
      }
    }

    return true;
  }

  @override
  List<Object?> get props => [product.id, quantity, size, toppings, note];

  OrderEntity copyWith({
    ProductDetailEntity? product,
    int? quantity,
    SizeEntity? size,
    List<ToppingEntity>? toppings,
    String? note,
  }) {
    return OrderEntity(
      product: product ?? this.product,
      quantity: quantity ?? this.quantity,
      size: size ?? this.size,
      toppings: toppings ?? this.toppings,
      note: note ?? this.note,
    );
  }

  factory OrderEntity.fromModel(OrderModel model) {
    return OrderEntity(
      product: ProductDetailEntity.fromModel(model.product),
      quantity: model.quantity,
      size: model.size == null ? null : SizeEntity.fromModel(model.size!),
      toppings: model.toppings.map((e) => ToppingEntity.fromModel(e)).toList(),
      note: model.note,
    );
  }
}
