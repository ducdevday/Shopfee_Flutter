enum HistoryStatus {
  WAITING,
  IN_PROCESS,
  SUCCEED,
  CANCELED,
  NOT_RECEIVED;

  String toJson() => name;

  static HistoryStatus fromJson(String json) => values.byName(json);
}
