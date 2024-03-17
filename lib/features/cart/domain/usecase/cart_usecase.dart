import 'package:shopfee/features/cart/data/models/order_result.dart';
import 'package:shopfee/features/cart/domain/entities/cart_entity.dart';
import 'package:shopfee/features/cart/domain/repositories/cart_repository.dart';
import 'package:shopfee/features/saved_address/domain/entities/address_entity.dart';
import 'package:shopfee/features/store_detail/domain/entities/store_detail_entity.dart';

abstract class CartUseCase {
  Future<AddressEntity?> getDefaultAddress(String userId);

  Future<AddressEntity?> getChosenShippingAddress(String addressId);

  Future<OrderResult> createShippingOrder(CartEntity cart, String userId);

  Future<OrderResult> createTakeAwayOrder(CartEntity cart, String userId);

  Future<StoreDetailEntity?> getNearestStore(double latitude, double longitude);

  Future<StoreDetailEntity> getDetailStore(String branchId);

  Future<double?> getShippingFee(double lat, double lng);
}

class CartUseCaseImpl extends CartUseCase {
  final CartRepository _cartRepository;

  CartUseCaseImpl(this._cartRepository);

  @override
  Future<AddressEntity?> getDefaultAddress(String userId) async {
    return await _cartRepository.getDefaultAddress(userId);
  }

  @override
  Future<AddressEntity?> getChosenShippingAddress(String addressId) async {
    return await _cartRepository.getChosenShippingAddress(addressId);
  }

  @override
  Future<OrderResult> createShippingOrder(
      CartEntity cart, String userId) async {
    return await _cartRepository.createShippingOrder(cart, userId);
  }

  @override
  Future<OrderResult> createTakeAwayOrder(CartEntity cart, String userId) async{
    return await _cartRepository.createTakeAwayOrder(cart, userId);
  }

  @override
  Future<StoreDetailEntity?> getNearestStore(
      double latitude, double longitude) async {
    return await _cartRepository.getNearestStore(latitude, longitude);
  }

  @override
  Future<StoreDetailEntity> getDetailStore(String branchId) async{
    return await _cartRepository.getDetailStore(branchId);
  }

  @override
  Future<double?> getShippingFee(double lat, double lng) async{
    return await _cartRepository.getShippingFee(lat, lng);
  }
}
