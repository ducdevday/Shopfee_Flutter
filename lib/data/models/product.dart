import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';
import 'package:shopfee/data/models/image.dart';
import 'package:shopfee/data/models/size.dart';
import 'package:shopfee/data/models/topping.dart';

class Product extends Equatable {
  final String? id;
  final String? name;
  final List<ImageModel>? imageList;
  final List<SizeModel>? sizeList;
  final String? description;
  final List<Topping>? toppingList;
  final String categoryId;

  const Product({
    this.id,
    this.name,
    this.imageList,
    this.sizeList,
    this.description,
    this.toppingList,
    required this.categoryId,
  });

  // String get priceString => '${NumberFormat.decimalPattern().format(price)}đ';

  @override
  List<Object?> get props =>
      [id, name, imageList, sizeList, description, toppingList, categoryId,];

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'name': this.name,
      'imageList': this.imageList,
      'sizeList': this.sizeList,
      'description': this.description,
      'toppingList': this.toppingList,
      'categoryId': this.categoryId,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'] as String,
      name: map["name"] as String,
      imageList: (map['imageList'] as List<dynamic>?)
          ?.map((e) => ImageModel.fromMap(e as Map<String, dynamic>))
          .toList(),
      sizeList: (map['sizeList'] as List<dynamic>?)
          ?.map((e) => SizeModel.fromMap(e as Map<String, dynamic>))
          .toList(),
      description: map['description'] as String,
      toppingList: (map['toppingList'] as List<dynamic>?)
          ?.map((e) => Topping.fromMap(e as Map<String, dynamic>))
          .toList(),
      categoryId: map['categoryId'] as String,
    );
  }

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] as String,
      name: json["name"] as String,
      imageList: (json['imageList'] as List<dynamic>?)
          ?.map((e) => ImageModel.fromMap(e as Map<String, dynamic>))
          .toList(),
      sizeList: (json['sizeList'] as List<dynamic>?)
          ?.map((e) => SizeModel.fromMap(e as Map<String, dynamic>))
          .toList(),
      description: json['description'] as String,
      toppingList: (json['toppingList'] as List<dynamic>?)
          ?.map((e) => Topping.fromMap(e as Map<String, dynamic>))
          .toList(),
      categoryId: json['categoryId'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': this.id,
      'name': this.name,
      'imageList': this.imageList,
      'sizeList': this.sizeList,
      'description': this.description,
      'toppingList': this.toppingList,
      'categoryId': this.categoryId,
    };
  }
}
