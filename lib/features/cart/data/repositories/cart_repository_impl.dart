import 'package:dio/dio.dart';
import 'package:shopfee/core/common/models/result.dart';
import 'package:shopfee/core/common/models/result_list.dart';
import 'package:shopfee/core/errors/app_exception.dart';
import 'package:shopfee/core/utils/format_util.dart';
import 'package:shopfee/features/cart/data/datasources/cart_service.dart';
import 'package:shopfee/features/cart/data/models/cart_model.dart';
import 'package:shopfee/features/cart/data/models/check_shipping_result.dart';
import 'package:shopfee/features/cart/data/models/check_take_away_result.dart';
import 'package:shopfee/features/cart/data/models/order_result.dart';
import 'package:shopfee/features/cart/domain/entities/cart_entity.dart';
import 'package:shopfee/features/cart/domain/entities/cart_extension.dart';
import 'package:shopfee/features/cart/domain/repositories/cart_repository.dart';
import 'package:shopfee/features/coupon_in_cart/data/models/coupon_check_result_model.dart';
import 'package:shopfee/features/coupon_in_cart/domain/entities/coupon_check_result_entity.dart';
import 'package:shopfee/features/product_detail/data/models/product_detail_model.dart';
import 'package:shopfee/features/product_detail/domain/entities/product_detail_entity.dart';
import 'package:shopfee/features/saved_address/data/models/address_model.dart';
import 'package:shopfee/features/saved_address/domain/entities/address_entity.dart';
import 'package:shopfee/features/store_detail/data/models/store_detail_model.dart';
import 'package:shopfee/features/store_detail/domain/entities/store_detail_entity.dart';

class CartRepositoryImpl implements CartRepository {
  final CartService _cartService;

  CartRepositoryImpl(this._cartService);

  @override
  Future<ProductDetailEntity> getProductById(String productId) async {
    final response = await _cartService.getProductById(productId);
    final result = Result(
      success: response.data["success"],
      message: response.data["message"],
      data: response.data["data"],
    );
    final productDetailModel = ProductDetailModel.fromJson(result.data!);
    final productDetailEntity =
        ProductDetailEntity.fromModel(productDetailModel);
    return productDetailEntity;
  }

  @override
  Future<AddressEntity?> getDefaultAddress(String userId) async {
    final responseAllAddress = await _cartService.getAllAddress(userId);
    final resultAllAddress = ResultList(
        success: responseAllAddress.data["success"],
        message: responseAllAddress.data["message"],
        data: responseAllAddress.data["data"]);
    List<AddressModel> addressesModel =
        resultAllAddress.data!.map((e) => AddressModel.fromJson(e)).toList();
    List<AddressEntity> addressesEntity =
        addressesModel.map((e) => AddressEntity.fromModel(e)).toList();

    if (addressesEntity.isNotEmpty) {
      final AddressEntity defaultAddress =
          addressesEntity.firstWhere((address) => address.isDefault == true);
      final responseDetailAddress =
          await _cartService.getAddressDetail(defaultAddress.id!);
      final resultDetailAddress = Result(
        success: responseDetailAddress.data["success"],
        message: responseDetailAddress.data["message"],
        data: responseDetailAddress.data["data"],
      );
      final addressModel = AddressModel.fromJson(resultDetailAddress.data!);
      final addressEntity = AddressEntity.fromModel(addressModel);
      return addressEntity;
    }
    return null;
  }

  @override
  Future<AddressEntity?> getChosenShippingAddress(String addressId) async {
    final responseDetailAddress =
        await _cartService.getAddressDetail(addressId);
    final resultDetailAddress = Result(
      success: responseDetailAddress.data["success"],
      message: responseDetailAddress.data["message"],
      data: responseDetailAddress.data["data"],
    );
    final addressModel = AddressModel.fromJson(resultDetailAddress.data!);
    final addressEntity = AddressEntity.fromModel(addressModel);
    return addressEntity;
  }

  @override
  Future<OrderResult> createShippingOrder(
      CartEntity cart, String userId) async {
    final response = await _cartService.createShippingOrder(
        CartModel.fromEntity(cart),
        userId,
        cart.getCartTotalPrice(),
        cart.productCouponCode,
        cart.orderCouponCode,
        cart.shippingCouponCode);
    final result = Result(
      success: response.data["success"],
      message: response.data["message"],
      data: response.data["data"],
    );
    final orderResult = OrderResult(
        orderId: result.data!["orderId"],
        transactionId: result.data!["transactionId"],
        paymentUrl: result.data!["paymentUrl"],
        branchId: result.data!["branchId"]);
    return orderResult;
  }

  @override
  Future<OrderResult> createTakeAwayOrder(
      CartEntity cart, String userId) async {
    try {
      final response = await _cartService.createTakeAwayOrder(
          CartModel.fromEntity(cart),
          userId,
          cart.getCartTotalPrice(),
          cart.productCouponCode,
          cart.orderCouponCode,
          cart.shippingCouponCode);
      final result = Result(
        success: response.data["success"],
        message: response.data["message"],
        data: response.data["data"],
      );
      final orderResult = OrderResult(
          orderId: result.data!["orderId"],
          transactionId: result.data!["transactionId"],
          paymentUrl: result.data!["paymentUrl"],
          branchId: result.data!["branchId"]);

      //TODO Send Notify
      // await _cartService.sendOrderMessage(
      //     "Shopfee For Employee Announce",
      //     "The order ${orderResult.orderId} was created. Please tap to see details",
      //     orderResult.orderId!);
      return orderResult;
    } catch (e) {
      // if (e is DioException) {
      //   if (e.response?.statusCode == 500) {
      //     throw ServerFailure(message: "VNPAY are only applicable for orders over ${FormatUtil.formatMoney(10000)}");
      //   }
      // }
      rethrow;
    }
  }

  @override
  Future<StoreDetailEntity?> getNearestStore(
      double latitude, double longitude) async {
    final currentTime = FormatUtil.formatSQLTime(DateTime.now());
    final response =
        await _cartService.getNearestStore(latitude, longitude, currentTime);
    final result = Result(
      success: response.data["success"],
      message: response.data["message"],
      data: response.data["data"],
    );
    final storeModel = StoreDetailModel.fromJson(result.data!);
    final storeEntity = StoreDetailEntity.fromModel(storeModel);
    return storeEntity;
  }

  @override
  Future<StoreDetailEntity> getDetailStore(String branchId) async {
    final response = await _cartService.getDetailStore(branchId);
    final result = Result(
      success: response.data["success"],
      message: response.data["message"],
      data: response.data["data"],
    );
    final storeModel = StoreDetailModel.fromJson(result.data!);
    final storeEntity = StoreDetailEntity.fromModel(storeModel);
    return storeEntity;
  }

  @override
  Future<double?> getShippingFee(double lat, double lng) async {
    try {
      final response = await _cartService.getShippingFee(lat, lng);
      final result = Result(
        success: response.data["success"],
        message: response.data["message"],
        data: response.data["data"],
      );
      final int shippingFee = result.data!["shippingFee"] as int;
      return shippingFee.toDouble();
    } catch (e) {
      if (e is DioException) {
        if (e.response?.statusCode == 404) {
          throw ServerFailure(
              message:
                  "Not found - Can't find a branch that can serve your current location and time");
        }
      }
      rethrow;
    }
  }

  @override
  Future<List<CouponCheckResultEntity>> checkCouponInCart(
      CartEntity cart) async {
    final response = await _cartService.checkCouponInCart(
        CartModel.fromEntity(cart),
        cart.totalItemPrice,
        cart.getCartTotalPrice(),
        cart.shippingCouponCode,
        cart.orderCouponCode,
        cart.productCouponCode);
    final resultList = ResultList(
      success: response.data["success"],
      message: response.data["message"],
      data: response.data["data"],
    );
    List<CouponCheckResultModel> couponChecksModel = resultList.data!
        .map((c) => CouponCheckResultModel.fromJson(c))
        .toList();
    List<CouponCheckResultEntity> couponChecksEntity = couponChecksModel
        .map((c) => CouponCheckResultEntity.fromModel(c))
        .toList();
    return couponChecksEntity;
  }

  @override
  Future<CheckTakeAwayResult> checkTakeAwayOrder(CartEntity cart) async {
    final response =
        await _cartService.checkTakeAwayOrder(CartModel.fromEntity(cart));
    final result = Result(
      success: response.data["success"],
      message: response.data["message"],
      data: response.data["data"],
    );
    final resultCheck = CheckTakeAwayResult.fromJson(result.data!);
    return resultCheck;
  }

  @override
  Future<CheckShippingResult> checkShippingOrder(CartEntity cart) async {
    final response =
        await _cartService.checkShippingOrder(CartModel.fromEntity(cart));
    final result = Result(
      success: response.data["success"],
      message: response.data["message"],
      data: response.data["data"],
    );
    final resultCheck = CheckShippingResult.fromJson(result.data!);
    return resultCheck;
  }
}
