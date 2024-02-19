enum PaymentType {
  CASHING,
  BANKING;

  String toJson() => name;

  static PaymentType fromJson(String json) => values.byName(json);
}