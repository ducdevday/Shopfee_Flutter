import 'package:shopfee/features/search/data/models/autocomplete_product_model.dart';

class AutocompleteProductEntity{
  final List<String> autocompleteTextList;
  final List<String> highlightTextList;

  const AutocompleteProductEntity({
    required this.autocompleteTextList,
    required this.highlightTextList,
  });

  factory AutocompleteProductEntity.fromModel(AutocompleteProductModel model) {
    return AutocompleteProductEntity(
      autocompleteTextList: model.autocompleteTextList,
      highlightTextList: model.highlightTextList,
    );
  }
}