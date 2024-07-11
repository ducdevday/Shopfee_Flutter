// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_query_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchQueryModel _$SearchQueryModelFromJson(Map<String, dynamic> json) =>
    SearchQueryModel(
      json['branch_id'] as String?,
      json['min_price'] as num?,
      json['max_price'] as num?,
      json['min_star'] as num?,
      $enumDecodeNullable(_$ProductSortTypeEnumMap, json['sort_type']),
    );

Map<String, dynamic> _$SearchQueryModelToJson(SearchQueryModel instance) =>
    <String, dynamic>{
      'branch_id': instance.branchId,
      'min_price': instance.minPrice,
      'max_price': instance.maxPrice,
      'min_star': instance.minStar,
      'sort_type': instance.sortType,
    };

const _$ProductSortTypeEnumMap = {
  ProductSortType.PRICE_DESC: 'PRICE_DESC',
  ProductSortType.PRICE_ASC: 'PRICE_ASC',
  ProductSortType.STAR_ASC: 'STAR_ASC',
  ProductSortType.STAR_DESC: 'STAR_DESC',
};
