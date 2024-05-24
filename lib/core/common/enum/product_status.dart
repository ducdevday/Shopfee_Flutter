
enum ProductStatus {
  AVAILABLE,
  HIDDEN,
  TEMPORARY_SUSPENDED;

  String toJson() => name;

  static ProductStatus fromJson(String json) => values.byName(json);

}
