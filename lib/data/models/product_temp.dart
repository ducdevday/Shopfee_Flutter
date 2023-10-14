import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

class ProductTemp extends Equatable {
  final String id;
  final String name;
  final String description;
  final double price;
  final double oldPrice;
  final double rating;
  final String image;

  ProductTemp(
      {required this.id,
      required this.name,
      required this.description,
      required this.price,
      required this.oldPrice,
      required this.rating,
      required this.image});

  String get priceString => '${NumberFormat.decimalPattern().format(price)}đ';

  @override
  List<Object> get props => [
        id,
        name,
        description,
        price,
        oldPrice,
        rating,
        image,
      ];

  static List<ProductTemp> products = [
    ProductTemp(
        id: '1',
        name: "Coffee Milk",
        description: "Ice americano + fresh milk Ice americano + fresh milk Ice americano + fresh milk Ice americano + fresh milk Ice americano + fresh milk Ice americano + fresh milk Ice americano + fresh milk Ice americano + fresh milk Ice americano + fresh milk Ice americano + fresh milk Ice americano + fresh milk",
        price: 25000,
        oldPrice: 28000,
        rating: 4.9,
        image:
            "https://firebasestorage.googleapis.com/v0/b/shopfee-12b03.appspot.com/o/product%2Fcoffee_big_1.png?alt=media&token=7b0b233d-f8d4-453d-8e17-bc8c39b4ae9e"),
    ProductTemp(
        id: '2',
        name: "Coffee Milk",
        description: "Ice americano + fresh milk ",
        price: 25000,
        oldPrice: 28000,
        rating: 4.9,
        image:
            "https://firebasestorage.googleapis.com/v0/b/shopfee-12b03.appspot.com/o/product%2Fcoffee1.png?alt=media&token=274503e4-9efd-4649-aba5-781e457932cb"),
    ProductTemp(
        id: '3',
        name: "Coffee Milk",
        description: "Ice americano + fresh milk ",
        price: 25000,
        oldPrice: 28000,
        rating: 4.9,
        image:
            "https://firebasestorage.googleapis.com/v0/b/shopfee-12b03.appspot.com/o/product%2Fcoffee1.png?alt=media&token=274503e4-9efd-4649-aba5-781e457932cb"),
    ProductTemp(
        id: '4',
        name: "Coffee Milk",
        description: "Ice americano + fresh milk ",
        price: 25000,
        oldPrice: 28000,
        rating: 4.9,
        image:
            "https://firebasestorage.googleapis.com/v0/b/shopfee-12b03.appspot.com/o/product%2Fcoffee1.png?alt=media&token=274503e4-9efd-4649-aba5-781e457932cb"),
    ProductTemp(
        id: '5',
        name: "Coffee Milk",
        description: "Ice americano + fresh milk ",
        price: 25000,
        oldPrice: 28000,
        rating: 4.9,
        image:
            "https://firebasestorage.googleapis.com/v0/b/shopfee-12b03.appspot.com/o/product%2Fcoffee1.png?alt=media&token=274503e4-9efd-4649-aba5-781e457932cb"),
    ProductTemp(
        id: '6',
        name: "Coffee Milk",
        description: "Ice americano + fresh milk ",
        price: 25000,
        oldPrice: 28000,
        rating: 4.9,
        image:
            "https://firebasestorage.googleapis.com/v0/b/shopfee-12b03.appspot.com/o/product%2Fcoffee1.png?alt=media&token=274503e4-9efd-4649-aba5-781e457932cb"),
    ProductTemp(
        id: '7',
        name: "Coffee Milk",
        description: "Ice americano + fresh milk ",
        price: 25000,
        oldPrice: 28000,
        rating: 4.9,
        image:
            "https://firebasestorage.googleapis.com/v0/b/shopfee-12b03.appspot.com/o/product%2Fcoffee1.png?alt=media&token=274503e4-9efd-4649-aba5-781e457932cb"),
    ProductTemp(
        id: '8',
        name: "Coffee Milk",
        description: "Ice americano + fresh milk ",
        price: 25000,
        oldPrice: 28000,
        rating: 4.9,
        image:
            "https://firebasestorage.googleapis.com/v0/b/shopfee-12b03.appspot.com/o/product%2Fcoffee1.png?alt=media&token=274503e4-9efd-4649-aba5-781e457932cb"),
    ProductTemp(
        id: '9',
        name: "Coffee Milk",
        description: "Ice americano + fresh milk ",
        price: 25000,
        oldPrice: 28000,
        rating: 4.9,
        image:
            "https://firebasestorage.googleapis.com/v0/b/shopfee-12b03.appspot.com/o/product%2Fcoffee1.png?alt=media&token=274503e4-9efd-4649-aba5-781e457932cb")
  ];
}
