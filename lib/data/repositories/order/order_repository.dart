import 'package:dio/dio.dart';
import 'package:shopfee/data/base/base_service.dart';
import 'package:shopfee/data/models/cart.dart';
import 'package:shopfee/data/models/event_log.dart';
import 'package:shopfee/data/models/result.dart';
import 'package:shopfee/data/models/result_list.dart';
import 'package:shopfee/data/models/review.dart';
import 'package:shopfee/data/models/status_order.dart';
import 'package:shopfee/data/repositories/order/order_repository_base.dart';

class OrderRepository extends OrderRepositoryBase {
  @override
  Future<Result> createShippingOrder(Cart cart, String userId) async {
    Map<String, dynamic> body = {
      "userId": userId,
      "products": cart.orders.map((order) => order.toMapOrder()).toList(),
      "note": cart.note,
      "paymentType": cart.typePayment!.name,
      "address": cart.address!.toMapOrder()
    };
    try {
      var response = await dio.post("${BaseService.orderPath}", data: body);
      return Result(
        success: response.data["success"],
        message: response.data["message"],
        data: response.data["data"],
      );
    } catch (e) {
      print(e);
      if (e is DioError) {
        final response = e.response;
        return Result(
            success: response?.data["success"],
            message: response?.data["message"]);
      }
      return Result(success: false, message: e.toString());
    }
  }

  @override
  Future<Result> getDetailsOrder(String orderId) async {
    try {
      var response = await dio.get("${BaseService.orderPath}/details/$orderId");
      return Result(
        success: response.data["success"],
        message: response.data["message"],
        data: response.data["data"],
      );
    } catch (e) {
      print(e);
      if (e is DioError) {
        final response = e.response;
        return Result(
            success: response?.data["success"],
            message: response?.data["message"]);
      }
      return Result(success: false, message: e.toString());
    }
  }

  @override
  Future<ResultList> getStatusOrder(String orderId) async {
    try {
      var response = await dio.get("${BaseService.orderPath}/status/$orderId");
      return ResultList(
        success: response.data["success"],
        message: response.data["message"],
        data: response.data["data"],
      );
    } catch (e) {
      print(e);
      if (e is DioError) {
        final response = e.response;
        return ResultList(
            success: response?.data["success"],
            message: response?.data["message"]);
      }
      return ResultList(success: false, message: e.toString());
    }
  }

  @override
  Future<Result> createReview(String orderId, Review review) async {
    Map<String, dynamic> body = {
      "rating": review.rating,
      "content": review.content,
    };
    try {
      var response = await dio.post("${BaseService.orderPath}/rating/$orderId",
          data: body);
      return Result(
        success: response.data["success"],
        message: response.data["message"],
        data: response.data["data"],
      );
    } catch (e) {
      print(e);
      if (e is DioError) {
        final response = e.response;
        return Result(
            success: response?.data["success"],
            message: response?.data["message"]);
      }
      return Result(success: false, message: e.toString());
    }
  }

  @override
  Future<ResultList> getHistoryOrder(
      String userId, OrderStatus orderStatus, {required int page,required int size}) async {
    Map<String, dynamic> queryParameters = {
      "orderStatus": orderStatus.name,
      "page": page,
      "size": size
    };
    try {
      var response = await dio.get(
          "${BaseService.orderPath}/history/user/$userId",
          queryParameters: queryParameters);
      return ResultList(
        success: response.data["success"],
        message: response.data["message"],
        data: response.data["data"],
      );
    } catch (e) {
      print(e);
      if (e is DioError) {
        final response = e.response;
        return ResultList(
            success: response?.data["success"],
            message: response?.data["message"]);
      }
      return ResultList(success: false, message: e.toString());
    }
  }

  @override
  Future<Result> addEventLog(String orderId, EventLog eventLog) async {
    Map<String, dynamic> body = {
      "orderStatus": eventLog.orderStatus.name,
      "description": eventLog.description
    };
    try {
      var response =
          await dio.patch("${BaseService.orderPath}/user/$orderId", data: body);
      return Result(
        success: response.data["success"],
        message: response.data["message"],
        data: response.data["data"],
      );
    } catch (e) {
      print(e);
      if (e is DioError) {
        final response = e.response;
        return Result(
            success: response?.data["success"],
            message: response?.data["message"]);
      }
      return Result(success: false, message: e.toString());
    }
  }
}
