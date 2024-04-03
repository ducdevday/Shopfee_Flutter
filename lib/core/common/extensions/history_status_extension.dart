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
    }
  }
}