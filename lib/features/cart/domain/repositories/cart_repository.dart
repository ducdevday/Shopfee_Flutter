import 'package:shopfee/features/cart/data/models/order_result.dart';
import 'package:shopfee/features/cart/domain/entities/cart_entity.dart';
import 'package:shopfee/features/saved_address/domain/entities/address_entity.dart';

abstract class CartRepository {
  Future<AddressEntity?> getDefaultAddress(String userId);
  Future<AddressEntity?> getChosenAddress(String addressId);
  Future<OrderResult> createShippingOrder(CartEntity cart, String userId);
}