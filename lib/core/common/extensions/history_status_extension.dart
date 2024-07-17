import 'package:easy_localization/easy_localization.dart';
import 'package:shopfee/core/common/enum/history_status.dart';
import 'package:shopfee/core/global/r.dart';

extension HistoryStatusExtension on HistoryStatus{
  String getFormattedName(){
    switch(this){
      case HistoryStatus.WAITING:
        return R.waiting.tr();
      case HistoryStatus.IN_PROCESS:
        return R.processing.tr();
      case HistoryStatus.SUCCEED:
        return R.succeed.tr();
      case HistoryStatus.CANCELED:
        return R.canceled.tr();
      case HistoryStatus.NOT_RECEIVED:
        return R.notReceived.tr();
    }
  }

  String getEmptyListString() {
    switch (this) {
      case HistoryStatus.WAITING:
        return R.nowating.tr();
      case HistoryStatus.IN_PROCESS:
        return R.noInProcess.tr();
      case HistoryStatus.SUCCEED:
        return R.noSucceed.tr();
      case HistoryStatus.CANCELED:
        return R.noCanceled.tr();
      case HistoryStatus.NOT_RECEIVED:
        return R.noReceived.tr();
    }
  }
}