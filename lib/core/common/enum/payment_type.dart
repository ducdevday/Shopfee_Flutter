enum PaymentType {
  CASHING,
  BANKING_VNPAY;

  String toJson() => name;

  static PaymentType fromJson(String json) => values.byName(json);
}