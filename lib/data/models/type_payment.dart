enum TypePayment {
  CASHING,
  BANKING;

  String toJson() => name;

  static TypePayment fromJson(String json) => values.byName(json);
}