enum Gender {
  FEMALE,
  MALE,
  OTHER;

  String toJson() => name;

  static Gender fromJson(String json) => values.byName(json);
}
