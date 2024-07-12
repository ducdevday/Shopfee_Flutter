// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'autocomplete_product_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AutocompleteProductModel _$AutocompleteProductModelFromJson(
        Map<String, dynamic> json) =>
    AutocompleteProductModel(
      autocompleteTextList: (json['autocompleteTextList'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      highlightTextList: (json['highlightTextList'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$AutocompleteProductModelToJson(
        AutocompleteProductModel instance) =>
    <String, dynamic>{
      'autocompleteTextList': instance.autocompleteTextList,
      'highlightTextList': instance.highlightTextList,
    };
