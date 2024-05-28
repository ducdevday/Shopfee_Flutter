enum ProductStatus {
  AVAILABLE,
  HIDDEN,
  TEMPORARY_SUSPENDED,
  UNAVAILABLE;

  String toJson() => name;

  static ProductStatus fromJson(String json) => values.byName(json);
}
