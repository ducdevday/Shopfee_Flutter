enum StoreStatus{
  ACTIVE,
  UNACTIVE;

  String toJson() => name;

  static StoreStatus fromJson(String json) => values.byName(json);
}