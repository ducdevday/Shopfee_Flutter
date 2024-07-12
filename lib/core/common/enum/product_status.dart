enum ProductStatus {
  AVAILABLE,
  HIDDEN,
  UNAVAILABLE;

  String toJson() => name;

  static ProductStatus fromJson(String json) => values.byName(json);
}
