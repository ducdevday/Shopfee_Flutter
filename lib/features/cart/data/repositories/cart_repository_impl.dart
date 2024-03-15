import 'package:shopfee/core/common/models/result.dart';
import 'package:shopfee/core/common/models/result_list.dart';
import 'package:shopfee/features/cart/data/datasources/cart_service.dart';
import 'package:shopfee/features/cart/data/models/cart_model.dart';
import 'package:shopfee/features/cart/data/models/order_result.dart';
import 'package:shopfee/features/cart/domain/entities/cart_entity.dart';
import 'package:shopfee/features/cart/domain/repositories/cart_repository.dart';
import 'package:shopfee/features/saved_address/data/models/address_model.dart';
import 'package:shopfee/features/saved_address/domain/entities/address_entity.dart';
import 'package:shopfee/features/store_detail/data/models/store_detail_model.dart';
import 'package:shopfee/features/store_detail/domain/entities/store_detail_entity.dart';

class CartRepositoryImpl implements CartRepository {
  final CartService _cartService;

  CartRepositoryImpl(this._cartService);

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
  Future<AddressEntity?> getChosenAddress(String addressId) async {
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
        CartModel.fromEntity(cart), userId);
    final result = Result(
      success: response.data["success"],
      message: response.data["message"],
      data: response.data["data"],
    );
    final orderResult = OrderResult(
        orderId: result.data!["orderId"],
        transactionId: result.data!["transactionId"],
        paymentUrl: result.data!["paymentUrl"]);

    await _cartService.sendOrderMessage(
        "Shopfee For Employee Announce",
        "The order ${orderResult.orderId} was created. Please tap to see details",
        orderResult.orderId!);
    return orderResult;
  }

  @override
  Future<OrderResult> createTakeAwayOrder(
      CartEntity cart, String userId) async {
    final response = await _cartService.createTakeAwayOrder(
        CartModel.fromEntity(cart), userId);
    final result = Result(
      success: response.data["success"],
      message: response.data["message"],
      data: response.data["data"],
    );
    final orderResult = OrderResult(
        orderId: result.data!["orderId"],
        transactionId: result.data!["transactionId"],
        paymentUrl: result.data!["paymentUrl"]);
    await _cartService.sendOrderMessage(
        "Shopfee For Employee Announce",
        "The order ${orderResult.orderId} was created. Please tap to see details",
        orderResult.orderId!);
    return orderResult;
  }

  @override
  Future<StoreDetailEntity?> getNearestStore(
      double latitude, double longitude) async {
    final response = await _cartService.getNearestStore(latitude, longitude);
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
}
