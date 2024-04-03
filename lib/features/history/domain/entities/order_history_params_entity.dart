
import 'package:shopfee/core/common/enum/history_status.dart';

class OrderHistoryParamsEntity{
  final HistoryStatus historyStatus;
  final int page;
  final int size;

  const OrderHistoryParamsEntity({
    required this.historyStatus,
    required this.page,
    required this.size,
  });
}
