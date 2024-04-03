// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_detail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductDetailModel _$ProductDetailModelFromJson(Map<String, dynamic> json) =>
    ProductDetailModel(
      id: json['id'] as String?,
      name: json['name'] as String?,
      imageUrl: json['imageUrl'] as String?,
      sizeList: (json['sizeList'] as List<dynamic>?)
          ?.map((e) => SizeModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      description: json['description'] as String?,
      toppingList: (json['toppingList'] as List<dynamic>?)
          ?.map((e) => ToppingModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      status: $enumDecodeNullable(_$ProductStatusEnumMap, json['status']),
      ratingSummary: json['ratingSummary'] == null
          ? null
          : RatingSummaryModel.fromJson(
              json['ratingSummary'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ProductDetailModelToJson(ProductDetailModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'imageUrl': instance.imageUrl,
      'sizeList': instance.sizeList,
      'description': instance.description,
      'toppingList': instance.toppingList,
      'status': instance.status,
      'ratingSummary': instance.ratingSummary,
    };

const _$ProductStatusEnumMap = {
  ProductStatus.AVAILABLE: 'AVAILABLE',
  ProductStatus.HIDDEN: 'HIDDEN',
  ProductStatus.OUT_OF_STOCK: 'OUT_OF_STOCK',
};
