import 'package:dio/dio.dart';
import 'package:shopfee/core/base/dio_service.dart';
import 'package:shopfee/features/coin/data/models/coin_history_params.dart';

class CoinService {
  Future<Response> getCoinHistory(String userId, CoinHistoryParams params) async {
    final response = await DioService.instance
        .get("${DioService.userPath}/$userId/coin-history",queryParameters: params.toJson());
    return response;
  }
}
