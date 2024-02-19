import 'package:shopfee/features/cart/data/models/order_result.dart';
import 'package:shopfee/features/cart/domain/entities/cart_entity.dart';
import 'package:shopfee/features/cart/domain/repositories/cart_repository.dart';
import 'package:shopfee/features/saved_address/domain/entities/address_entity.dart';

abstract class CartUseCase {
  Future<AddressEntity?> getDefaultAddress(String userId);

  Future<AddressEntity?> getChosenAddress(String addressId);

  Future<OrderResult> createShippingOrder(CartEntity cart, String userId);
}

class CartUseCaseImpl extends CartUseCase {
  final CartRepository _cartRepository;

  CartUseCaseImpl(this._cartRepository);

  @override
  Future<AddressEntity?> getDefaultAddress(String userId) async {
    return await _cartRepository.getDefaultAddress(userId);
  }

  @override
  Future<AddressEntity?> getChosenAddress(String addressId) async {
    return await _cartRepository.getChosenAddress(addressId);
  }

  @override
  Future<OrderResult> createShippingOrder(
      CartEntity cart, String userId) async {
    return await _cartRepository.createShippingOrder(cart, userId);
  }
}
