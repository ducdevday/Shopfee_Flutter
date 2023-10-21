import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:shopfee/data/models/address.dart';
import 'package:shopfee/data/models/order.dart';
import 'package:shopfee/data/models/type_payment.dart';
import 'package:shopfee/data/models/voucher.dart';

part 'cart.g.dart';

enum TypeDelivery {
  TakeAway,
  HomeDelivery;

  String toJson() => name;

  static TypeDelivery fromJson(String json) => values.byName(json);
}

@JsonSerializable()
class Cart extends Equatable {
  final List<Order> orders;
  final TypeDelivery? typeDelivery;
  final Address? address;
  final String? note;
  final DateTime? deliveryTime;
  final TypePayment? typePayment;
  final Voucher? voucher;
  final double? shippingFee;

  const Cart({
    this.orders = const <Order>[],
    this.typeDelivery,
    this.address,
    this.note,
    this.deliveryTime,
    this.typePayment = TypePayment.CASHING,
    this.voucher,
    this.shippingFee = 18000,
  });

  int get totalQuantity =>
      orders.fold(0, (total, current) => total + current.quantity);

  String get quantityTotalString => "${totalQuantity} item";

  double get totalPrice =>
      orders.fold(0, (total, current) => total + current.total);

  String get totalPriceString =>
      "${NumberFormat.decimalPattern().format(totalPrice)}đ";

  String get nameOrderString {
    List<String> results = [];
    orders.map((order) => order.product.name).forEach((name) {
      results.add(name!);
    });
    return results.join(", ");
  }

  @override
  List<Object?> get props => [
        orders,
        typeDelivery,
        address,
        note,
        deliveryTime,
        typePayment,
        voucher,
        shippingFee,
      ];

  @override
  String toString() {
    return 'Cart{' +
        ' orders: $orders,' +
        ' typeDelivery: $typeDelivery,' +
        ' address: $address,' +
        ' note: $note,' +
        ' deliveryTime: $deliveryTime,' +
        ' typePayment: $typePayment,' +
        ' voucher: $voucher,' +
        ' shippingFee: $shippingFee,' +
        '}';
  }

  Cart copyWith({
    List<Order>? orders,
    TypeDelivery? typeDelivery,
    Address? address,
    String? note,
    DateTime? deliveryTime,
    TypePayment? typePayment,
    Voucher? voucher,
    double? shippingFee,
  }) {
    return Cart(
      orders: orders ?? this.orders,
      typeDelivery: typeDelivery ?? this.typeDelivery,
      address: address ?? this.address,
      note: note ?? this.note,
      deliveryTime: deliveryTime ?? this.deliveryTime,
      typePayment: typePayment ?? this.typePayment,
      voucher: voucher ?? this.voucher,
      shippingFee: shippingFee ?? this.shippingFee,
    );
  }

  factory Cart.fromJson(Map<String, dynamic> json) => _$CartFromJson(json);

  Map<String, dynamic> toJson() => _$CartToJson(this);
}
