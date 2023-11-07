import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:shopfee/data/models/image.dart';
import 'package:shopfee/data/models/size.dart';
import 'package:shopfee/data/models/topping.dart';

part 'product.g.dart';

@JsonSerializable()
class Product extends Equatable {
  final String? id;
  final String? name;
  final String? imageUrl;
  final List<SizeModel>? sizeList;
  final String? description;
  final List<Topping>? toppingList;

  const Product({
    this.id,
    this.name,
    this.imageUrl,
    this.sizeList,
    this.description,
    this.toppingList,
  });

  // String get priceString => '${NumberFormat.decimalPattern().format(price)}đ';

  @override
  List<Object?> get props =>
      [id, name, imageUrl, sizeList, description, toppingList];

  factory Product.fromJson(Map<String, dynamic> json) => _$ProductFromJson(json);

  Map<String, dynamic> toJson() => _$ProductToJson(this);
}
