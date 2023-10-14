import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

class SizeModel extends Equatable {
  final String size;
  final double price;

  SizeModel({required this.size, required this.price});

  @override
  List<Object> get props => [size, price];

  String get priceString => '${NumberFormat.decimalPattern().format(price)}đ';

  Map<String, dynamic> toMap() {
    return {
      'size': this.size,
      'price': this.price,
    };
  }

  factory SizeModel.fromMap(Map<String, dynamic> map) {
    return SizeModel(
      size: map['size'] as String,
      price: map['price'] as double,
    );
  }

  factory SizeModel.fromJson(Map<String, dynamic> json) {
    return SizeModel(
      size: json["size"],
      price: json["price"] as double,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "size": this.size,
      "price": this.price,
    };
  }
}