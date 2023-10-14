import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

class Topping extends Equatable {
  final String name;
  final double price;

  Topping({required this.name, required this.price});

  @override
  List<Object> get props => [name, price];

  String get priceString => '${NumberFormat.decimalPattern().format(price)}đ';

  Map<String, dynamic> toMap() {
    return {
      'name': this.name,
      'price': this.price,
    };
  }

  factory Topping.fromMap(Map<String, dynamic> map) {
    return Topping(
      name: map['name'] as String,
      price: map['price'] as double,
    );
  }

  factory Topping.fromJson(Map<String, dynamic> json) {
    return Topping(
      name: json["name"],
      price: json["price"] as double,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "name": this.name,
      "price": this.price,
    };
  }
}
