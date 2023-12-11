import 'package:dio/dio.dart';
import 'package:shopfee/data/base/base_service.dart';
import 'package:shopfee/data/models/result.dart';
import 'package:shopfee/data/repositories/transaction/transaction_repository_base.dart';

class TransactionRepository extends TransactionRepositoryBase{
  @override
  Future<Result> updateTransaction(String transactionId) async {
    try{
      var response = await dio.patch("${BaseService.transactionPath}/$transactionId");
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