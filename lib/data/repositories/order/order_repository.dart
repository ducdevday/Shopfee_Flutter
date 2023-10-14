import 'package:dio/dio.dart';
import 'package:shopfee/data/base/base_service.dart';
import 'package:shopfee/data/models/cart.dart';
import 'package:shopfee/data/models/result.dart';
import 'package:shopfee/data/models/result_string.dart';
import 'package:shopfee/data/repositories/order/order_repository_base.dart';

class OrderRepository extends OrderRepositoryBase{

  @override
  Future<Result> createShippingOrder(Cart cart, String userId) async{
    Map<String, dynamic> body ={
      "userId": userId,
      "products": cart.orders.map((order) => order.toMapOrder()).toList(),
      "note": cart.note,
      "paymentType": cart.typePayment!.name,
      "address": cart.address!.toMapOrder()
    };
    try{
      var response = await dio.post("${BaseService.orderPath}", data: body);
      return Result(
          success: response.data["success"],
          message: response.data["message"],
          data: response.data["data"],
      );
    }
    catch(e){
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
  Future<Result> getDetailsOrder(String orderId) async{
    try{
      var response = await dio.get("${BaseService.orderPath}/details/$orderId");
      return Result(
        success: response.data["success"],
        message: response.data["message"],
        data: response.data["data"],
      );
    }
    catch(e){
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