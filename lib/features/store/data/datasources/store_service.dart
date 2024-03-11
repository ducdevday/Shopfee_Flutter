import 'package:dio/dio.dart';
import 'package:shopfee/core/base/dio_service.dart';
import 'package:shopfee/features/store/data/models/store_all_params_model.dart';

class StoreService {
  Future<Response> getAllStores(StoreAllParamsModel params) async {
    final response = await DioService.instance.get(
        "${DioService.branchPath}/active",
        queryParameters: params.toJson());
    return response;
  }
}
