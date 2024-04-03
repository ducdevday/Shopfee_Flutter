enum HistoryStatus {
  WAITING,
  IN_PROCESS,
  SUCCEED,
  CANCELED;

  String toJson() => name;

  static HistoryStatus fromJson(String json) => values.byName(json);
}
