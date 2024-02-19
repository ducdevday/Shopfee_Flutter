import 'package:json_annotation/json_annotation.dart';
import 'package:shopfee/features/product_detail/data/models/topping_model.dart';

part 'receipt_product_model.g.dart';

@JsonSerializable()
class ReceiptProductModel {
  String? id;
  String? name;
  int? quantity;
  String? size;
  double? price;
  List<ToppingModel>? toppings;
  String? note;

  ReceiptProductModel({
    this.id,
    this.name,
    this.quantity,
    this.size,
    this.price,
    this.toppings,
    this.note,
  });

  factory ReceiptProductModel.fromJson(Map<String, dynamic> json) {
    return _$ReceiptProductModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$ReceiptProductModelToJson(this);
  }
}
