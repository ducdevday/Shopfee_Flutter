

import 'package:json_annotation/json_annotation.dart';

part 'coin_history_model.g.dart';

@JsonSerializable()
class CoinHistoryModel {
  final num? coin;
  final String? description;
  final DateTime? createdAt;

  const CoinHistoryModel({
    this.coin,
    this.description,
    this.createdAt,
  });

  factory CoinHistoryModel.fromJson(Map<String, dynamic> json) {
    return _$CoinHistoryModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$CoinHistoryModelToJson(this);
  }
}
