enum ProductSortType {
  PRICE_DESC,
  PRICE_ASC;

  String toJson() => name;

  static ProductSortType fromJson(String json) => values.byName(json);
}
