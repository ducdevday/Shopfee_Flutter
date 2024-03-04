enum ProductSortType {
  PRICE_DESC,
  PRICE_ASC;

  String toJson() => name;

  static ProductSortType fromJson(String json) => values.byName(json);

  static String getName(ProductSortType type) {
    switch (type) {
      case PRICE_DESC:
        return "High to low price";
      case PRICE_ASC:
        return "Low to high price";
      default:
        return "";
    }
  }
}
