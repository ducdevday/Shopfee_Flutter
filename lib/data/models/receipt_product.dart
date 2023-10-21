import 'package:intl/intl.dart';
import 'package:shopfee/data/models/topping.dart';

class ReceiptProduct {
  String? id;
  String? name;
  int? quantity;
  String? size;
  double? price;
  List<Topping>? toppings;
  String? note;

  ReceiptProduct({
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

  String get totalString => "${NumberFormat.decimalPattern().format(total)}đ";

  factory ReceiptProduct.fromJson(Map<String, dynamic> json) {
    return ReceiptProduct(
      id: json["id"],
      name: json["name"],
      quantity: json["quantity"] as int,
      size: json["size"],
      price: json["price"] as double,
      toppings:
          List.of(json["toppings"]).map((i) => Topping.fromMap(i)).toList(),
      note: json["note"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": this.id,
      "name": this.name,
      "quantity": this.quantity,
      "size": this.size,
      "price": this.price,
      "toppings": this.toppings,
      "note": this.note,
    };
  }
}
