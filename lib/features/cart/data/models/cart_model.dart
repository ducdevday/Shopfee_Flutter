import 'package:json_annotation/json_annotation.dart';
import 'package:shopfee/core/common/enum/delivery_type.dart';
import 'package:shopfee/core/common/enum/payment_type.dart';
import 'package:shopfee/core/common/models/order_type.dart';
import 'package:shopfee/features/cart/domain/entities/cart_entity.dart';
import 'package:shopfee/features/product_detail/data/models/order_model.dart';
import 'package:shopfee/features/saved_address/data/models/address_model.dart';

part 'cart_model.g.dart';

@JsonSerializable()
class CartModel {
  final List<OrderModel> orders;
  final OrderType? orderType;
  final AddressModel? address;
  final String? note;
  final DateTime? receiveTime;
  final PaymentType? paymentType;

  // final Voucher? voucher;
  final double? shippingFee;

  const CartModel({
    required this.orders,
    this.orderType,
    this.address,
    this.note,
    this.receiveTime,
    this.paymentType,
    // this.voucher,
    this.shippingFee,
  });

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return _$CartModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$CartModelToJson(this);
  }



  factory CartModel.fromEntity(CartEntity entity) {
    return CartModel(
      orders: entity.orders.map((e) => OrderModel.fromEntity(e)).toList(),
      orderType: entity.orderType,
      address: entity.address == null
          ? null
          : AddressModel.fromEntity(entity.address!),
      note: entity.note,
      receiveTime: entity.receiveTime,
      paymentType: entity.paymentType,
      shippingFee: entity.shippingFee,
    );
  }
}
