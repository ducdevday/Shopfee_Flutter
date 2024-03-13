import 'package:dio/dio.dart';
import 'package:shopfee/core/base/dio_service.dart';


class StoreDetailService {

  Future<Response> getDetailStore(int branchId) async{
      final response = await DioService.instance.get("${DioService.branchPath}/$branchId/detail");
      return response;
  }
}