enum StatusPayment {
  PAID,
  UNPAID,
  REFUNDED;

  String toJson() => name;

  static StatusPayment fromJson(String json) => values.byName(json);
}