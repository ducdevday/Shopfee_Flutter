import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

class ToppingTemp extends Equatable {
  final String id;
  final String name;
  final double price;

  ToppingTemp(this.id, this.name, this.price);

  @override
  List<Object> get props => [id, name, price];

  String get priceString => '${NumberFormat.decimalPattern().format(price)}đ';

  static List<ToppingTemp> toppings =[
    ToppingTemp("1", "Extra Espresso", 5000),
    ToppingTemp("2", "Cincau", 5000),
    ToppingTemp("3", "Coffee Jelly", 5000),
    ToppingTemp("4", "Chocolate Ice Cream", 5000),
  ];
}
