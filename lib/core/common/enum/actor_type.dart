enum ActorType {
  EMPLOYEE,
  USER,
  AUTOMATIC;

  String toJson() => name;

  static ActorType fromJson(String json) => values.byName(json);
}