import 'package:equatable/equatable.dart';

class Product extends Equatable {
  final String name;
  final String descrition;
  final double price;
  final double oldPrice;
  final double rating;
  final String image;

  Product(
      {required this.name,
      required this.descrition,
      required this.price,
      required this.oldPrice,
      required this.rating,
      required this.image});

  String get priceString => '${price.toString()}đ';

  @override
  List<Object> get props => [
        name,
        descrition,
        price,
        oldPrice,
        rating,
        image,
      ];

  static List<Product> products = [
    Product(
        name: "Coffee Milk",
        descrition: "Ice americano + fresh milk ",
        price: 25000,
        oldPrice: 28000,
        rating: 4.9,
        image:
            "https://firebasestorage.googleapis.com/v0/b/shopfee-12b03.appspot.com/o/product%2Fcoffee1.png?alt=media&token=274503e4-9efd-4649-aba5-781e457932cb"),
    Product(
        name: "Coffee Milk",
        descrition: "Ice americano + fresh milk ",
        price: 25000,
        oldPrice: 28000,
        rating: 4.9,
        image:
            "https://firebasestorage.googleapis.com/v0/b/shopfee-12b03.appspot.com/o/product%2Fcoffee1.png?alt=media&token=274503e4-9efd-4649-aba5-781e457932cb"),
    Product(
        name: "Coffee Milk",
        descrition: "Ice americano + fresh milk ",
        price: 25000,
        oldPrice: 28000,
        rating: 4.9,
        image:
            "https://firebasestorage.googleapis.com/v0/b/shopfee-12b03.appspot.com/o/product%2Fcoffee1.png?alt=media&token=274503e4-9efd-4649-aba5-781e457932cb"),
    Product(
        name: "Coffee Milk",
        descrition: "Ice americano + fresh milk ",
        price: 25000,
        oldPrice: 28000,
        rating: 4.9,
        image:
            "https://firebasestorage.googleapis.com/v0/b/shopfee-12b03.appspot.com/o/product%2Fcoffee1.png?alt=media&token=274503e4-9efd-4649-aba5-781e457932cb"),
    Product(
        name: "Coffee Milk",
        descrition: "Ice americano + fresh milk ",
        price: 25000,
        oldPrice: 28000,
        rating: 4.9,
        image:
            "https://firebasestorage.googleapis.com/v0/b/shopfee-12b03.appspot.com/o/product%2Fcoffee1.png?alt=media&token=274503e4-9efd-4649-aba5-781e457932cb"),
    Product(
        name: "Coffee Milk",
        descrition: "Ice americano + fresh milk ",
        price: 25000,
        oldPrice: 28000,
        rating: 4.9,
        image:
            "https://firebasestorage.googleapis.com/v0/b/shopfee-12b03.appspot.com/o/product%2Fcoffee1.png?alt=media&token=274503e4-9efd-4649-aba5-781e457932cb"),
    Product(
        name: "Coffee Milk",
        descrition: "Ice americano + fresh milk ",
        price: 25000,
        oldPrice: 28000,
        rating: 4.9,
        image:
            "https://firebasestorage.googleapis.com/v0/b/shopfee-12b03.appspot.com/o/product%2Fcoffee1.png?alt=media&token=274503e4-9efd-4649-aba5-781e457932cb"),
    Product(
        name: "Coffee Milk",
        descrition: "Ice americano + fresh milk ",
        price: 25000,
        oldPrice: 28000,
        rating: 4.9,
        image:
            "https://firebasestorage.googleapis.com/v0/b/shopfee-12b03.appspot.com/o/product%2Fcoffee1.png?alt=media&token=274503e4-9efd-4649-aba5-781e457932cb"),
    Product(
        name: "Coffee Milk",
        descrition: "Ice americano + fresh milk ",
        price: 25000,
        oldPrice: 28000,
        rating: 4.9,
        image:
            "https://firebasestorage.googleapis.com/v0/b/shopfee-12b03.appspot.com/o/product%2Fcoffee1.png?alt=media&token=274503e4-9efd-4649-aba5-781e457932cb")
  ];
}
