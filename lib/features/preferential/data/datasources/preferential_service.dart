import 'package:dio/dio.dart';
import 'package:shopfee/core/base/dio_service.dart';


class PreferentialService {

  Future<Response> doSomeThing(String query) async{
      final response = await DioService.instance.get("path");
      return response;
  }
}