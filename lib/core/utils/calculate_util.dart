class CalculateUtil {
  static int distanceBetween2Date(DateTime startDate, DateTime endDate) {
    return endDate.difference(startDate).inDays;
  }

  static int compareBetween2Date(DateTime dateTime1, DateTime dateTime2) {
    if (dateTime1.isBefore(dateTime2)) {
      return -1;
    } else if (dateTime1.isAfter(dateTime2)) {
      return 1;
    } else {
      return 0;
    }
  }

  static DateTime getDateTime7DaysAgo(){
    return DateTime.now().subtract(Duration(days: 7));
  }

  static DateTime getDateTime31DaysAgo(){
    return DateTime.now().subtract(Duration(days: 31));
  }
}
