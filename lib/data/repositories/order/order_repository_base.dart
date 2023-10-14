import 'package:shopfee/data/base/base_service.dart';
import 'package:shopfee/data/models/cart.dart';
import 'package:shopfee/data/models/result.dart';
import 'package:shopfee/data/models/result_string.dart';

abstract class OrderRepositoryBase extends BaseService{
  Future<Result> createShippingOrder(Cart cart, String userId);
  Future<Result> getDetailsOrder(String orderId);
}