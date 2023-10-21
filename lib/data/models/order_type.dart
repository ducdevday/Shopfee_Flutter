enum OrderType {
  SHIPPING,
  ONSITE;

  String toJson() => name;

  static OrderType fromJson(String json) => values.byName(json);
}
