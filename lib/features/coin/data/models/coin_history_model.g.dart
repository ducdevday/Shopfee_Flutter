// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coin_history_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CoinHistoryModel _$CoinHistoryModelFromJson(Map<String, dynamic> json) =>
    CoinHistoryModel(
      coin: json['coin'] as num?,
      description: json['description'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$CoinHistoryModelToJson(CoinHistoryModel instance) =>
    <String, dynamic>{
      'coin': instance.coin,
      'description': instance.description,
      'createdAt': instance.createdAt?.toIso8601String(),
    };
