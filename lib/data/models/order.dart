import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';
import 'package:shopfee/data/models/topping.dart';

import 'product.dart';

enum Variant { Ice, Hot }

enum Size { Small, Medium, Large }

enum Sugar { Normal, Less }

class Order extends Equatable {
  final Product product;
  final int quantity;
  final Variant? variant;
  final Size? size;
  final Sugar? sugar;
  final List<Topping> toppings;
  final String note;


  const Order(
      {required this.product,
      this.quantity = 1,
      this.variant,
      this.size,
      this.sugar,
      this.toppings = const <Topping>[],
      this.note = ""});

  double get total => quantity * product.price + toppings.fold(0, (total, current) => total + current.price);

  String get totalString => "${NumberFormat.decimalPattern().format(total)}đ";

  @override
  List<Object?> get props =>
      [product, quantity, variant, size, sugar, toppings, note];

  @override
  String toString() {
    return 'Order{' +
        ' productID: $product,' +
        ' quantity: $quantity,' +
        ' variant: $variant,' +
        ' size: $size,' +
        ' sugar: $sugar,' +
        ' toppings: $toppings,' +
        ' note: $note,' +
        '}';
  }

  Order copyWith({
    String? productID,
    int? quantity,
    Variant? variant,
    Size? size,
    Sugar? sugar,
    List<Topping>? toppings,
    String? note,
  }) {
    return Order(
      product: product ?? this.product,
      quantity: quantity ?? this.quantity,
      variant: variant ?? this.variant,
      size: size ?? this.size,
      sugar: sugar ?? this.sugar,
      toppings: toppings ?? this.toppings,
      note: note ?? this.note,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'product': this.product,
      'quantity': this.quantity,
      'variant': this.variant,
      'size': this.size,
      'sugar': this.sugar,
      'toppings': this.toppings,
      'note': this.note,
    };
  }

  factory Order.fromMap(Map<String, dynamic> map) {
    return Order(
      product: map['product'] as Product,
      quantity: map['quantity'] as int,
      variant: map['variant'] as Variant,
      size: map['size'] as Size,
      sugar: map['sugar'] as Sugar,
      toppings: map['toppings'] as List<Topping>,
      note: map['note'] as String,
    );
  }
}
