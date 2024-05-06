enum RewardUnit{
  PERCENTAGE,
  MONEY;

  String toJson() => name;

  static RewardUnit fromJson(String json) => values.byName(json);
}