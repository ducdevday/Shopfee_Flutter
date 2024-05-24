import 'package:json_annotation/json_annotation.dart';

part 'autocomplete_product_model.g.dart';

@JsonSerializable()
class AutocompleteProductModel {
  final List<String> autocompleteTextList;
  final List<String> highlightTextList;

  const AutocompleteProductModel({
    required this.autocompleteTextList,
    required this.highlightTextList,
  });

  factory AutocompleteProductModel.fromJson(Map<String, dynamic> json) {
    return _$AutocompleteProductModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$AutocompleteProductModelToJson(this);
  }
}
