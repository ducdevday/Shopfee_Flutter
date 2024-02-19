import 'package:shopfee/features/product_detail/domain/entities/topping_entity.dart';
import 'package:shopfee/features/receipt/data/models/receipt_product_model.dart';

class ReceiptProductEntity {
  String? id;
  String? name;
  int? quantity;
  String? size;
  double? price;
  List<ToppingEntity>? toppings;
  String? note;

  ReceiptProductEntity({
    this.id,
    this.name,
    this.quantity,
    this.size,
    this.price,
    this.toppings,
    this.note,
  }); //

  String get toppingOrderString {
    List<String> results = [];
    toppings!.map((t) => t.name).forEach((name) {
      results.add(name);
    });
    return results.join(", ");
  }

  double get total =>
      quantity! * price! +
      quantity! * toppings!.fold(0, (total, current) => total + current.price);

  factory ReceiptProductEntity.fromModel(ReceiptProductModel model) {
    return ReceiptProductEntity(
        id: model.id,
        name: model.name,
        quantity: model.quantity,
        size: model.size,
        price: model.price,
        toppings:
            model.toppings?.map((e) => ToppingEntity.fromModel(e)).toList(),
        note: model.note);
  }
}
