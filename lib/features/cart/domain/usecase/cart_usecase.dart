import 'package:shopfee/core/socket/socket_method.dart';
import 'package:shopfee/features/cart/data/models/check_shipping_result.dart';
import 'package:shopfee/features/cart/data/models/check_take_away_result.dart';
import 'package:shopfee/features/cart/data/models/order_result.dart';
import 'package:shopfee/features/cart/domain/entities/cart_entity.dart';
import 'package:shopfee/features/cart/domain/repositories/cart_repository.dart';
import 'package:shopfee/features/coupon_in_cart/domain/entities/coupon_check_result_entity.dart';
import 'package:shopfee/features/product_detail/domain/entities/order_entity.dart';
import 'package:shopfee/features/product_detail/domain/entities/product_detail_entity.dart';
import 'package:shopfee/features/product_detail/domain/entities/size_entity.dart';
import 'package:shopfee/features/product_detail/domain/entities/topping_entity.dart';
import 'package:shopfee/features/saved_address/domain/entities/address_entity.dart';
import 'package:shopfee/features/store_detail/domain/entities/store_detail_entity.dart';

abstract class CartUseCase {
  Future<List<OrderEntity>> updateOrderInformation(
      List<OrderEntity> currentOrders);

  Future<AddressEntity?> getDefaultAddress(String userId);

  Future<AddressEntity?> getChosenShippingAddress(String addressId);

  Future<OrderResult> createShippingOrder(CartEntity cart, String userId);

  Future<OrderResult> createTakeAwayOrder(CartEntity cart, String userId);

  Future<StoreDetailEntity?> getNearestStore(double latitude, double longitude);

  Future<StoreDetailEntity> getDetailStore(String branchId);

  Future<double?> getShippingFee(double lat, double lng);

  Future<List<CouponCheckResultEntity>> checkCouponInCart(CartEntity cart,);

  Future<CheckTakeAwayResult> checkTakeAwayOrder(CartEntity cart);

  Future<CheckShippingResult> checkShippingOrder(CartEntity cart);
}

class CartUseCaseImpl extends CartUseCase {
  final CartRepository _cartRepository;
  final SocketMethod _socketMethod;

  CartUseCaseImpl(this._cartRepository, this._socketMethod);

  @override
  Future<AddressEntity?> getDefaultAddress(String userId) async {
    return await _cartRepository.getDefaultAddress(userId);
  }

  @override
  Future<AddressEntity?> getChosenShippingAddress(String addressId) async {
    return await _cartRepository.getChosenShippingAddress(addressId);
  }

  @override
  Future<OrderResult> createShippingOrder(CartEntity cart,
      String userId) async {
    final orderResult = await _cartRepository.createShippingOrder(cart, userId);
    _socketMethod.createOrder(
        branchId: orderResult.branchId!, orderId: orderResult.orderId!);
    return orderResult;
  }

  @override
  Future<OrderResult> createTakeAwayOrder(CartEntity cart,
      String userId) async {
    final orderResult = await _cartRepository.createTakeAwayOrder(cart, userId);
    _socketMethod.createOrder(
        branchId: cart.store!.id!, orderId: orderResult.orderId!);
    return orderResult;
  }

  @override
  Future<StoreDetailEntity?> getNearestStore(double latitude,
      double longitude) async {
    return await _cartRepository.getNearestStore(latitude, longitude);
  }

  @override
  Future<StoreDetailEntity> getDetailStore(String branchId) async {
    return await _cartRepository.getDetailStore(branchId);
  }

  @override
  Future<double?> getShippingFee(double lat, double lng) async {
    return await _cartRepository.getShippingFee(lat, lng);
  }

  @override
  Future<List<CouponCheckResultEntity>> checkCouponInCart(
      CartEntity cart) async {
    return await _cartRepository.checkCouponInCart(cart);
  }

  @override
  Future<List<OrderEntity>> updateOrderInformation(
      List<OrderEntity> currentOrders) async {
    final List<OrderEntity> updatedOrders = List.from(currentOrders);
    for (int index = 0; index < currentOrders.length; index++) {
      final ProductDetailEntity product = await _cartRepository
          .getProductById(currentOrders[index].product.id!);

      final SizeEntity? chosenSize = currentOrders[index].size;
      final List<ToppingEntity> chosenToppingList =
          currentOrders[index].toppings;

      SizeEntity? newSize = chosenSize;
      List<ToppingEntity> newToppingList = [];

      if (chosenSize != null && product.sizeList != null) {
        newSize = product.sizeList!.firstWhere(
                (size) => size.size == chosenSize.size,
            orElse: () => chosenSize);
      }

      if (chosenToppingList.isNotEmpty &&
          product.toppingList != null &&
          product.toppingList!.isNotEmpty) {
        newToppingList = product.toppingList!
            .where((topping) =>
            chosenToppingList
                .any((chosenTopping) => chosenTopping.name == topping.name))
            .toList();
      }

      updatedOrders[index] = updatedOrders[index]
          .copyWith(product: product, size: newSize, toppings: newToppingList);
    }
    return updatedOrders;
  }

  @override
  Future<CheckTakeAwayResult> checkTakeAwayOrder(CartEntity cart) async {
    return await _cartRepository.checkTakeAwayOrder(cart);
  }

  @override
  Future<CheckShippingResult> checkShippingOrder(CartEntity cart) async {
    return await _cartRepository.checkShippingOrder(cart);
  }
}
