enum ProductSortType {
  PRICE_DESC,
  PRICE_ASC,
  STAR_ASC,
  STAR_DESC
  ;


  String toJson() => name;

  static ProductSortType fromJson(String json) => values.byName(json);
}
