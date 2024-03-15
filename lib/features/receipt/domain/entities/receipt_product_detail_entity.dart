import 'package:shopfee/features/product_detail/domain/entities/topping_entity.dart';
import 'package:shopfee/features/receipt/data/models/receipt_product_detail_model.dart';

class ReceiptProductDetailEntity {
  int? quantity;
  String? size;
  double? price;
  List<ToppingEntity>? toppings;
  String? note;

  ReceiptProductDetailEntity({
    this.quantity,
    this.size,
    this.price,
    this.toppings,
    this.note,
  });

  String get toppingOrderString {
    List<String> results = [];
    toppings?.map((t) => t.name).forEach((name) {
      results.add(name);
    });
    return results.join(", ");
  }

  double get total =>
      quantity! * price! +
          quantity! * (toppings == null ? 0 : toppings!.fold(0, (total, current) => total + current.price));

  factory ReceiptProductDetailEntity.fromModel(
      ReceiptProductDetailModel model) {
    return ReceiptProductDetailEntity(
      quantity: model.quantity,
      size: model.size,
      price: model.price,
      toppings: model.toppings?.map((e) => ToppingEntity.fromModel(e)).toList(),
      note: model.note,
    );
  }
}
