import 'package:shopfee/features/cart/data/models/order_result.dart';
import 'package:shopfee/features/cart/domain/entities/cart_entity.dart';
import 'package:shopfee/features/saved_address/domain/entities/address_entity.dart';
import 'package:shopfee/features/store_detail/domain/entities/store_detail_entity.dart';

abstract class CartRepository {
  Future<AddressEntity?> getDefaultAddress(String userId);

  Future<AddressEntity?> getChosenShippingAddress(String addressId);

  Future<OrderResult> createShippingOrder(CartEntity cart, String userId);

  Future<OrderResult> createTakeAwayOrder(CartEntity cart, String userId);

  Future<StoreDetailEntity?> getNearestStore(double latitude, double longitude);

  Future<StoreDetailEntity> getDetailStore(String branchId);

  Future<double?> getShippingFee(double lat, double lng);
}
