import 'package:flutter/material.dart';
import 'package:shopfee/core/common/enum/payment_type.dart';
import 'package:shopfee/core/common/models/order_type.dart';
import 'package:shopfee/features/cart/data/models/cart_model.dart';
import 'package:shopfee/features/cart/domain/entities/shipping_strategy.dart';
import 'package:shopfee/features/cart/domain/entities/take_away_strategy.dart';
import 'package:shopfee/features/product_detail/domain/entities/order_entity.dart';
import 'package:shopfee/features/saved_address/domain/entities/address_entity.dart';
import 'package:shopfee/features/store_detail/domain/entities/store_detail_entity.dart';

class CartEntity {
  final List<OrderEntity> orders;
  final OrderType? orderType;
  final AddressEntity? address;
  final String? note;
  final StoreDetailEntity? store;
  final DateTime? receiveTime;
  final PaymentType? paymentType;

  // final Voucher? voucher;
  final double? shippingFee;
  final num? coin;

  const CartEntity(
      {this.orders = const <OrderEntity>[],
      this.orderType = OrderType.SHIPPING,
      this.address,
      this.note,
      this.store,
      this.receiveTime,
      this.paymentType = PaymentType.CASHING,
      // this.voucher,
      this.shippingFee,
      this.coin});

  int get totalQuantity =>
      orders.fold(0, (total, current) => total + current.quantity);

  double get totalItemPrice =>
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
    StoreDetailEntity? store,
    DateTime? receiveTime,
    PaymentType? paymentType,
    ValueGetter<double?>? shippingFee,
    ValueGetter<num?>? coin,
  }) {
    return CartEntity(
      orders: orders ?? this.orders,
      orderType: orderType ?? this.orderType,
      address: address ?? this.address,
      note: note ?? this.note,
      store: store ?? this.store,
      receiveTime: receiveTime ?? this.receiveTime,
      paymentType: paymentType ?? this.paymentType,
      shippingFee: shippingFee != null ? shippingFee() : this.shippingFee,
      coin: coin != null ? coin() : this.coin,
    );
  }

  factory CartEntity.fromModel(CartModel model) {
    return CartEntity(
        orders: model.orders.map((e) => OrderEntity.fromModel(e)).toList(),
        orderType: model.orderType,
        address: model.address == null
            ? null
            : AddressEntity.fromModel(model.address!),
        note: model.note,
        store: model.store == null
            ? null
            : StoreDetailEntity.fromModel(model.store!),
        receiveTime: model.receiveTime,
        paymentType: model.paymentType,
        shippingFee: model.shippingFee,
        coin: model.coin);
  }
}
