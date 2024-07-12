enum OrderStatus {
  CREATED,
  ACCEPTED,
  CANCELLATION_REQUEST,
  CANCELLATION_REQUEST_REFUSED,
  CANCELLATION_REQUEST_ACCEPTED,
  PENDING_PICK_UP,
  IN_DELIVERY,
  NOT_RECEIVED,
  CANCELED,
  SUCCEED;

  String toJson() => name;

  static OrderStatus fromJson(String json) => values.byName(json);
}
