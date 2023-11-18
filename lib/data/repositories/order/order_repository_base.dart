import 'package:shopfee/data/base/base_service.dart';
import 'package:shopfee/data/models/cart.dart';
import 'package:shopfee/data/models/event_log.dart';
import 'package:shopfee/data/models/result.dart';
import 'package:shopfee/data/models/result_list.dart';
import 'package:shopfee/data/models/review.dart';
import 'package:shopfee/data/models/status_order.dart';

abstract class OrderRepositoryBase extends BaseService{
  Future<Result> createShippingOrder(Cart cart, String userId);
  Future<Result> getDetailsOrder(String orderId);
  Future<Result> createReview(String orderId,Review review);
  Future<ResultList> getStatusOrder(String orderId);
  Future<Result> addEventLog(String orderId, EventLog eventLog);
  Future<ResultList> getHistoryOrder(String userId, OrderStatus orderStatus,
      {required int page,required int size});
}