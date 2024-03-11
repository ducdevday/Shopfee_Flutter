import 'package:dio/dio.dart';
import 'package:shopfee/core/base/dio_service.dart';


class TemplateService {

  Future<Response> doSomeThing(String query) async{
      final response = await DioService.instance.get("path");
      return response;
  }
}