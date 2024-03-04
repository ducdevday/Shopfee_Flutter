import 'package:shopfee/core/common/enum/delivery_type.dart';
import 'package:shopfee/core/common/enum/payment_type.dart';
import 'package:shopfee/core/common/models/order_type.dart';
import 'package:shopfee/features/cart/data/models/cart_model.dart';
import 'package:shopfee/features/product_detail/domain/entities/order_entity.dart';
import 'package:shopfee/features/saved_address/domain/entities/address_entity.dart';

class CartEntity {
  final List<OrderEntity> orders;
  final OrderType? orderType;
  final AddressEntity? address;
  final String? note;
  final DateTime? receiveTime;
  final PaymentType? paymentType;

  // final Voucher? voucher;
  final double? shippingFee;

  const CartEntity({
    this.orders = const <OrderEntity>[],
    this.orderType = OrderType.SHIPPING,
    this.address,
    this.note,
    this.receiveTime,
    this.paymentType = PaymentType.CASHING,
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
    OrderType? orderType,
    AddressEntity? address,
    String? note,
    DateTime? receiveTime,
    PaymentType? paymentType,
    double? shippingFee,
  }) {
    return CartEntity(
      orders: orders ?? this.orders,
      orderType: orderType ?? this.orderType,
      address: address ?? this.address,
      note: note ?? this.note,
      receiveTime: receiveTime ?? this.receiveTime,
      paymentType: paymentType ?? this.paymentType,
      shippingFee: shippingFee ?? this.shippingFee,
    );
  }

  factory CartEntity.fromModel(CartModel model) {
    return CartEntity(
      orders: model.orders.map((e) => OrderEntity.fromModel(e)).toList(),
      orderType: model.orderType,
      address: model.address == null ? null : AddressEntity.fromModel(model.address!),
      note: model.note,
      receiveTime: model.receiveTime,
      paymentType: model.paymentType,
      shippingFee: model.shippingFee,
    );
  }
}
