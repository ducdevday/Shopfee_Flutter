import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

class Topping extends Equatable {
  final String id;
  final String name;
  final double price;

  Topping(this.id, this.name, this.price);

  @override
  List<Object> get props => [id, name, price];

  String get priceString => '${NumberFormat.decimalPattern().format(price)}đ';

  static List<Topping> toppings =[
    Topping("1", "Extra Espresso", 5000),
    Topping("2", "Cincau", 5000),
    Topping("3", "Coffee Jelly", 5000),
    Topping("4", "Chocolate Ice Cream", 5000),
  ];
}
