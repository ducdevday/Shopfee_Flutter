import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';
import 'package:shopfee/data/models/address.dart';
import 'package:shopfee/data/models/order.dart';
import 'package:shopfee/data/models/voucher.dart';

enum TypeDelivery { TakeAway, HomeDelivery }

enum TypePayment { CASHING, BANKING  }

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
    this.typePayment,
    this.voucher,
    this.shippingFee = 18000,
  });

  int get totalQuantity =>
      orders.fold(0, (total, current) => total + current.quantity);

  String get quantityTotalString => "${totalQuantity} item";

  double get totalPrice => orders.fold(0, (total, current) => total + current.total);

  String get totalPriceString => "${NumberFormat.decimalPattern().format(totalPrice)}đ";

  String get nameOrderString {
    List<String> results = [];
    orders.map((order) => order.product.name).forEach((name) {results.add(name!); });
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

  Map<String, dynamic> toMap() {
    return {
      'orders': this.orders,
      'typeDelivery': this.typeDelivery,
      'address': this.address,
      'note': this.note,
      'deliveryTime': this.deliveryTime,
      'typePayment': this.typePayment,
      'voucher': this.voucher,
      'shippingFee': this.shippingFee,
    };
  }

  factory Cart.fromMap(Map<String, dynamic> map) {
    return Cart(
      orders: map['orders'] as List<Order>,
      typeDelivery: map['typeDelivery'] as TypeDelivery,
      address: map['address'] as Address,
      note: map['note'] as String,
      deliveryTime: map['deliveryTime'] as DateTime,
      typePayment: map['typePayment'] as TypePayment,
      voucher: map['voucher'] as Voucher,
      shippingFee: map['shippingFee'] as double,
    );
  }
}
