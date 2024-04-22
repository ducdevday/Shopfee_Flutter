import 'package:shopfee/features/coin/data/models/coin_history_params.dart';
import 'package:shopfee/features/coin/domain/entities/coin_history_entity.dart';

abstract class CoinRepository {
  Future<List<CoinHistoryEntity>> getCoinHistory(
      String userId, CoinHistoryParams params);
}
