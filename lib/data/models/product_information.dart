import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

class ProductInformation extends Equatable {
  final String id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;

  const ProductInformation({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
  });

  String get priceString => '${NumberFormat.decimalPattern().format(price)}đ';

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'name': this.name,
      'description': this.description,
      'price': this.price,
      'imageUrl': this.imageUrl,
    };
  }

  factory ProductInformation.fromMap(Map<String, dynamic> map) {
    return ProductInformation(
      id: map['id'] as String,
      name: map['name'] as String,
      description: map['description'] as String,
      price: map['price'] as double,
      imageUrl: map['thumbnailUrl'] as String,
    );
  }

  @override
  List<Object> get props => [id, name, description, price, imageUrl];
}