import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:shopfee/data/models/product.dart';
import 'package:shopfee/data/models/size.dart';
import 'package:shopfee/data/models/topping.dart';
import 'package:shopfee/data/models/topping_temp.dart';

import 'product_temp.dart';

// enum Size { Small, Medium, Large }
part 'order.g.dart';

@JsonSerializable()
class Order extends Equatable {
  final Product product;
  final int quantity;
  final SizeModel? size;
  final List<Topping> toppings;
  final String note;

  const Order(
      {required this.product,
      this.quantity = 1,
      this.size,
      this.toppings = const <Topping>[],
      this.note = ""});

  double get total =>
      quantity * size!.price +
      quantity * toppings.fold(0, (total, current) => total + current.price);

  String get totalString => "${NumberFormat.decimalPattern().format(total)}đ";

  String get toppingOrderString {
    List<String> results = [];
    toppings.map((t) => t.name).forEach((name) {
      results.add(name);
    });
    return results.join(", ");
  }

  bool isEqualExceptQuantity(Order order) {
    if (product.id == order.product.id &&
        size == order.size &&
        toppings == order.toppings &&
        note == order.note) {
      return true;
    }
    return false;
  }

  @override
  List<Object?> get props => [product.id, quantity, size, toppings, note];

  @override
  String toString() {
    return 'Order{' +
        ' productID: $product,' +
        ' quantity: $quantity,' +
        ' size: $size,' +
        ' toppings: $toppings,' +
        ' note: $note,' +
        '}';
  }

  Order copyWith({
    String? productID,
    int? quantity,
    SizeModel? size,
    List<Topping>? toppings,
    String? note,
  }) {
    return Order(
      product: product,
      quantity: quantity ?? this.quantity,
      size: size ?? this.size,
      toppings: toppings ?? this.toppings,
      note: note ?? this.note,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'product': this.product,
      'quantity': this.quantity,
      'size': this.size,
      'toppings': this.toppings,
      'note': this.note,
    };
  }

  Map<String, dynamic> toMapOrder() {
    return {
      'productId': this.product.id,
      'quantity': this.quantity,
      'toppings': this.toppings.map((topping) => topping.toMap()).toList(),
      'price': this.size!.price,
      'size': this.size!.size,
      'note': this.note,
    };
  }

  factory Order.fromMap(Map<String, dynamic> map) {
    return Order(
      product: map['product'] as Product,
      quantity: map['quantity'] as int,
      size: map['size'] as SizeModel,
      toppings: map['toppings'] as List<Topping>,
      note: map['note'] as String,
    );
  }

  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);
  Map<String, dynamic> toJson() => _$OrderToJson(this);


  // factory Order.fromJson(Map<String, dynamic> json) {
  //   return Order(
  //     product: Product.fromMap(json["product"]),
  //     quantity: json["quantity"] as int,
  //     size: SizeModel.fromMap(json["size"]),
  //     toppings: json['toppings'] as List<Topping>,
  //     note: json["note"],
  //   );
  // }
  //
  // Map<String, dynamic> toJson() {
  //   return {
  //     'product': this.product,
  //     'quantity': this.quantity,
  //     'size': this.size,
  //     'toppings': this.toppings.map((topping) => topping.toMap()).toList(),
  //     'note': this.note,
  //   };
  // }
}
