import 'package:shopfee/core/errors/app_exception.dart';
import 'package:shopfee/features/coin/data/models/coin_history_params.dart';
import 'package:shopfee/features/coin/domain/entities/coin_history_entity.dart';
import 'package:shopfee/features/coin/domain/repositories/coin_repository.dart';
import 'package:shopfee/features/template/domain/entities/template_entity.dart';
import 'package:shopfee/features/template/domain/repositories/template_repository.dart';

abstract class CoinUseCase {
  Future<List<CoinHistoryEntity>> getCoinHistory(
      String userId, CoinHistoryParams params);
}

class CoinUseCaseImpl extends CoinUseCase {
  final CoinRepository _coinRepository;

  CoinUseCaseImpl(this._coinRepository);

  @override
  Future<List<CoinHistoryEntity>> getCoinHistory(
      String userId, CoinHistoryParams params) async {
    return await _coinRepository.getCoinHistory(userId, params);
  }
}
