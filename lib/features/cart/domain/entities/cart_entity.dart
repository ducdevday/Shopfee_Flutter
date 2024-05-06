import 'package:flutter/material.dart';
import 'package:shopfee/core/common/enum/payment_type.dart';
import 'package:shopfee/core/common/models/order_type.dart';
import 'package:shopfee/features/cart/data/models/cart_model.dart';
import 'package:shopfee/features/cart/domain/entities/receiver_onsite_entity.dart';
import 'package:shopfee/features/coupon_in_cart/domain/entities/coupon_check_result_entity.dart';
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
  final double? shippingFee;
  final num? coin;
  final ReceiverOnsiteEntity? receiverOnsite;
  final String? shippingCouponCode;
  final String? orderCouponCode;
  final String? productCouponCode;
  final CouponCheckResultEntity? shippingCouponResult;
  final CouponCheckResultEntity? orderCouponResult;
  final CouponCheckResultEntity? productCouponResult;

  const CartEntity({
    this.orders = const <OrderEntity>[],
    this.orderType = OrderType.SHIPPING,
    this.address,
    this.note,
    this.store,
    this.receiveTime,
    this.paymentType = PaymentType.CASHING,
    this.shippingFee,
    this.coin,
    this.receiverOnsite,
    this.shippingCouponCode,
    this.orderCouponCode,
    this.productCouponCode,
    this.shippingCouponResult,
    this.orderCouponResult,
    this.productCouponResult,
  });

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
    ReceiverOnsiteEntity? receiverOnsite,
    ValueGetter<String?>? shippingCouponCode,
    ValueGetter<String?>? orderCouponCode,
    ValueGetter<String?>? productCouponCode,
    ValueGetter<CouponCheckResultEntity?>? shippingCouponResult,
    ValueGetter<CouponCheckResultEntity?>? orderCouponResult,
    ValueGetter<CouponCheckResultEntity?>? productCouponResult,
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
      receiverOnsite: receiverOnsite ?? this.receiverOnsite,
      shippingCouponCode: shippingCouponCode != null
          ? shippingCouponCode()
          : this.shippingCouponCode,
      orderCouponCode:
          orderCouponCode != null ? orderCouponCode() : this.orderCouponCode,
      productCouponCode: productCouponCode != null
          ? productCouponCode()
          : this.productCouponCode,
      shippingCouponResult: shippingCouponResult != null
          ? shippingCouponResult()
          : this.shippingCouponResult,
      orderCouponResult:
      orderCouponResult != null ? orderCouponResult() : this.orderCouponResult,
      productCouponResult: productCouponResult != null
          ? productCouponResult()
          : this.productCouponResult,
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
        coin: model.coin,
        receiverOnsite: model.receiverOnsite == null
            ? null
            : ReceiverOnsiteEntity.fromModel(model.receiverOnsite!),
    );
  }
}
