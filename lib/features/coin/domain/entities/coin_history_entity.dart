import 'package:shopfee/features/coin/data/models/coin_history_model.dart';
import 'package:shopfee/features/template/data/models/template_model.dart';

class CoinHistoryEntity {
  final num? coin;
  final String? description;
  final DateTime? createdAt;

  const CoinHistoryEntity({
    this.coin,
    this.description,
    this.createdAt,
  });

  factory CoinHistoryEntity.fromModel(CoinHistoryModel model) {
    return CoinHistoryEntity(
      coin: model.coin,
      description: model.description,
      createdAt: model.createdAt,
    );
  }
}
