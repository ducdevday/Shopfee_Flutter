enum HistoryStatus {
  WAITING,
  IN_PROCESS,
  SUCCEED,
  CANCELED;

  String toJson() => name;

  static HistoryStatus fromJson(String json) => values.byName(json);

  static String getName(HistoryStatus status){
    switch(status){
      case HistoryStatus.WAITING:
        return "Waiting";
      case HistoryStatus.IN_PROCESS:
        return "Processing";
      case HistoryStatus.SUCCEED:
        return "Succeed";
      case HistoryStatus.CANCELED:
        return "Canceled";
    }
  }
}
