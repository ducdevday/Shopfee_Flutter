import 'package:json_annotation/json_annotation.dart';
import 'package:shopfee/core/common/enum/delivery_type.dart';
import 'package:shopfee/core/common/enum/payment_type.dart';
import 'package:shopfee/features/cart/domain/entities/cart_entity.dart';
import 'package:shopfee/features/product_detail/data/models/order_model.dart';
import 'package:shopfee/features/saved_address/data/models/address_model.dart';

part 'cart_model.g.dart';

@JsonSerializable()
class CartModel {
  final List<OrderModel> orders;
  final DeliveryType? typeDelivery;
  final AddressModel? address;
  final String? note;
  final DateTime? deliveryTime;
  final PaymentType? typePayment;

  // final Voucher? voucher;
  final double? shippingFee;

  const CartModel({
    required this.orders,
    this.typeDelivery,
    this.address,
    this.note,
    this.deliveryTime,
    this.typePayment,
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
      typeDelivery: entity.typeDelivery,
      address: entity.address == null
          ? null
          : AddressModel.fromEntity(entity.address!),
      note: entity.note,
      deliveryTime: entity.deliveryTime,
      typePayment: entity.typePayment,
      shippingFee: entity.shippingFee,
    );
  }
}
