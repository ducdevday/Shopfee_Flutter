import 'package:shopfee/core/common/enum/history_status.dart';

extension HistoryStatusExtension on HistoryStatus{
  String getFormattedName(){
    switch(this){
      case HistoryStatus.WAITING:
        return "Waiting";
      case HistoryStatus.IN_PROCESS:
        return "Processing";
      case HistoryStatus.SUCCEED:
        return "Succeed";
      case HistoryStatus.CANCELED:
        return "Canceled";
      case HistoryStatus.NOT_RECEIVED:
        return "Not Received";
    }
  }

  String getEmptyListString() {
    switch (this) {
      case HistoryStatus.WAITING:
        return "No Order In Waiting";
      case HistoryStatus.IN_PROCESS:
        return "No Order In Processing";
      case HistoryStatus.SUCCEED:
        return "No Order Has Done";
      case HistoryStatus.CANCELED:
        return "No Order Has Canceled";
      case HistoryStatus.NOT_RECEIVED:
        return "No Order Not Received";
    }
  }
}