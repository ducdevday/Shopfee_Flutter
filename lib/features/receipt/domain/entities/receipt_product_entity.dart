import 'package:shopfee/features/product_detail/domain/entities/topping_entity.dart';
import 'package:shopfee/features/receipt/data/models/receipt_product_model.dart';
import 'package:shopfee/features/receipt/domain/entities/receipt_product_detail_entity.dart';

class ReceiptProductEntity {
  String? productId;
  String? name;
  List<ReceiptProductDetailEntity>? itemDetailList;

  ReceiptProductEntity({
    this.productId,
    this.name,
    this.itemDetailList,
  });

  factory ReceiptProductEntity.fromModel(ReceiptProductModel model) {
    return ReceiptProductEntity(
      productId: model.productId,
      name: model.name,
      itemDetailList: model.itemDetailList
          ?.map((e) => ReceiptProductDetailEntity.fromModel(e))
          .toList(),
    );
  }
}
