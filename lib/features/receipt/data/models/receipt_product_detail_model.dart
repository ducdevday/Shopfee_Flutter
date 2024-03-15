import 'package:json_annotation/json_annotation.dart';
import 'package:shopfee/features/product_detail/data/models/topping_model.dart';

part "receipt_product_detail_model.g.dart";

@JsonSerializable()
class ReceiptProductDetailModel{
  int? quantity;
  String? size;
  double? price;
  @JsonKey(name: "toppingList")
  List<ToppingModel>? toppings;
  String? note;

  ReceiptProductDetailModel({
    this.quantity,
    this.size,
    this.price,
    this.toppings,
    this.note,
  });

  factory ReceiptProductDetailModel.fromJson(Map<String, dynamic> json) {
    return _$ReceiptProductDetailModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$ReceiptProductDetailModelToJson(this);
  }
}