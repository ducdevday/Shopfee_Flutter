import 'package:shopfee/core/common/enum/product_sort_type.dart';

extension ProductSortTypeExtension on ProductSortType {
  String getFormattedName() {
    switch (this) {
      case ProductSortType.PRICE_DESC:
        return "High to low price";
      case ProductSortType.PRICE_ASC:
        return "Low to high price";
      default:
        return "";
    }
  }
}
