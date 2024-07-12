enum ReviewSortType {
  CREATED_AT_ASC,
  CREATED_AT_DESC,
  STAR_ASC,
  STAR_DESC;

  String toJson() => name;

  static ReviewSortType fromJson(String json) => values.byName(json);
}
