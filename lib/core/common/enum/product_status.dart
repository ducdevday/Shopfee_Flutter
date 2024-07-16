enum ProductStatus {
  ACTIVE,
  INACTIVE;

  String toJson() => name;

  static ProductStatus fromJson(String json) => values.byName(json);
}
