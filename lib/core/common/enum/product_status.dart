
enum ProductStatus {
  AVAILABLE,
  HIDDEN,
  OUT_OF_STOCK;

  String toJson() => name;

  static ProductStatus fromJson(String json) => values.byName(json);

}
