enum DeliveryType {
  TakeAway,
  HomeDelivery;

  String toJson() => name;

  static DeliveryType fromJson(String json) => values.byName(json);
}