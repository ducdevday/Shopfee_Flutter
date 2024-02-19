enum PaymentStatus {
  PAID,
  UNPAID,
  REFUNDED;

  String toJson() => name;

  static PaymentStatus fromJson(String json) => values.byName(json);
}