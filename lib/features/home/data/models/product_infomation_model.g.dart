// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_infomation_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductInformationModel _$ProductInformationModelFromJson(
        Map<String, dynamic> json) =>
    ProductInformationModel(
      id: json['id'] as String?,
      name: json['name'] as String?,
      description: json['description'] as String?,
      price: (json['price'] as num?)?.toDouble(),
      imageUrl: json['thumbnailUrl'] as String?,
    );

Map<String, dynamic> _$ProductInformationModelToJson(
        ProductInformationModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'price': instance.price,
      'thumbnailUrl': instance.imageUrl,
    };
