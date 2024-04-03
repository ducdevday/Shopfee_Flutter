import 'package:json_annotation/json_annotation.dart';
import 'package:shopfee/features/product_detail/data/models/topping_model.dart';
import 'package:shopfee/features/receipt/data/models/receipt_product_detail_model.dart';

part 'receipt_product_model.g.dart';

@JsonSerializable()
class ReceiptProductModel {
  String? productId;
  String? name;
  List<ReceiptProductDetailModel>? itemDetailList;

  ReceiptProductModel({
    this.productId,
    this.name,
    this.itemDetailList,
  });

  factory ReceiptProductModel.fromJson(Map<String, dynamic> json) {
    return _$ReceiptProductModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$ReceiptProductModelToJson(this);
  }


}
