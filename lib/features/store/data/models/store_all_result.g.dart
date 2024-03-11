// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'store_all_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StoreAllResult _$StoreAllResultFromJson(Map<String, dynamic> json) =>
    StoreAllResult(
      branchList: (json['branchList'] as List<dynamic>?)
          ?.map(
              (e) => StoreInformationModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalPage: json['totalPage'] as int?,
    );

Map<String, dynamic> _$StoreAllResultToJson(StoreAllResult instance) =>
    <String, dynamic>{
      'branchList': instance.branchList,
      'totalPage': instance.totalPage,
    };
