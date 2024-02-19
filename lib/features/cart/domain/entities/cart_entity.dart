import 'package:shopfee/core/common/enum/delivery_type.dart';
import 'package:shopfee/core/common/enum/payment_type.dart';
import 'package:shopfee/features/cart/data/models/cart_model.dart';
import 'package:shopfee/features/product_detail/domain/entities/order_entity.dart';
import 'package:shopfee/features/saved_address/domain/entities/address_entity.dart';

class CartEntity {
  final List<OrderEntity> orders;
  final DeliveryType? typeDelivery;
  final AddressEntity? address;
  final String? note;
  final DateTime? deliveryTime;
  final PaymentType? typePayment;

  // final Voucher? voucher;
  final double? shippingFee;

  const CartEntity({
    this.orders = const <OrderEntity>[],
    this.typeDelivery,
    this.address,
    this.note,
    this.deliveryTime,
    this.typePayment = PaymentType.CASHING,
    // this.voucher,
    this.shippingFee = 0,
  });

  int get totalQuantity =>
      orders.fold(0, (total, current) => total + current.quantity);

  double get totalPrice =>
      orders.fold(0, (total, current) => total + current.total);

  String get nameOrderString {
    List<String> results = [];
    orders.map((order) => order.product.name).forEach((name) {
      results.add(name!);
    });
    return results.join(", ");
  }

  CartEntity copyWith({
    List<OrderEntity>? orders,
    DeliveryType? typeDelivery,
    AddressEntity? address,
    String? note,
    DateTime? deliveryTime,
    PaymentType? typePayment,
    double? shippingFee,
  }) {
    return CartEntity(
      orders: orders ?? this.orders,
      typeDelivery: typeDelivery ?? this.typeDelivery,
      address: address ?? this.address,
      note: note ?? this.note,
      deliveryTime: deliveryTime ?? this.deliveryTime,
      typePayment: typePayment ?? this.typePayment,
      shippingFee: shippingFee ?? this.shippingFee,
    );
  }

  factory CartEntity.fromModel(CartModel model) {
    return CartEntity(
      orders: model.orders.map((e) => OrderEntity.fromModel(e)).toList(),
      typeDelivery: model.typeDelivery,
      address: model.address == null ? null : AddressEntity.fromModel(model.address!),
      note: model.note,
      deliveryTime: model.deliveryTime,
      typePayment: model.typePayment,
      shippingFee: model.shippingFee,
    );
  }
}
