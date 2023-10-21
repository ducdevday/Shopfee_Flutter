enum OrderStatus {
  CREATED,
  ACCEPTED,
  DELIVERING,
  CANCELED,
  SUCCEED;

  String toJson() => name;

  static OrderStatus fromJson(String json) => values.byName(json);
}
