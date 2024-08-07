import 'package:shopfee/features/cart/data/models/check_shipping_result.dart';
import 'package:shopfee/features/cart/data/models/check_take_away_result.dart';
import 'package:shopfee/features/cart/data/models/order_result.dart';
import 'package:shopfee/features/cart/domain/entities/cart_entity.dart';
import 'package:shopfee/features/coupon_in_cart/domain/entities/coupon_check_result_entity.dart';
import 'package:shopfee/features/product_detail/domain/entities/product_detail_entity.dart';
import 'package:shopfee/features/saved_address/domain/entities/address_entity.dart';
import 'package:shopfee/features/store_detail/domain/entities/store_detail_entity.dart';

abstract class CartRepository {
  Future<ProductDetailEntity> getProductById(String productId);

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
