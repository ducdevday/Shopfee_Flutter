import 'package:shopfee/core/common/models/result.dart';
import 'package:shopfee/features/coin/data/datasources/coin_service.dart';
import 'package:shopfee/features/coin/data/models/coin_history_model.dart';
import 'package:shopfee/features/coin/data/models/coin_history_params.dart';
import 'package:shopfee/features/coin/domain/entities/coin_history_entity.dart';
import 'package:shopfee/features/coin/domain/repositories/coin_repository.dart';
import 'package:shopfee/features/template/data/models/template_model.dart';
import 'package:shopfee/features/template/domain/entities/template_entity.dart';


class CoinRepositoryImpl implements CoinRepository {
  final CoinService _coinService;

  CoinRepositoryImpl(this._coinService);


  @override
  Future<List<CoinHistoryEntity>> getCoinHistory(String userId, CoinHistoryParams params) async{
    final response = await _coinService.getCoinHistory(userId, params);
    final result = Result(
        success: response.data["success"],
        message: response.data["message"],
        data: response.data["data"]);
    final List<dynamic> historyList = result.data!["coinHistoryList"] as List<dynamic>;
    List<CoinHistoryModel> coinHistoriesModel =
    historyList.map((p) => CoinHistoryModel.fromJson(p)).toList();
    List<CoinHistoryEntity> coinHistoriesEntity = coinHistoriesModel
        .map((p) => CoinHistoryEntity.fromModel(p))
        .toList();
    return coinHistoriesEntity;
  }
}
