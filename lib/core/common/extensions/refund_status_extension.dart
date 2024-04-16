import 'package:shopfee/core/common/enum/refund_status.dart';
import 'package:shopfee/core/config/app_path.dart';

extension RefundStatusExtension on RefundStatus {
  String getFormattedName() {
    switch (this) {
      case RefundStatus.PENDING:
        return "Pending";
      case RefundStatus.ACCEPTED:
        return "Accepted";
      case RefundStatus.REFUSED:
        return "Refused";
    }
  }

  String getResultString() {
    switch (this) {
      case RefundStatus.PENDING:
        return "Your request is under consideration";
      case RefundStatus.ACCEPTED:
        return "Your request is accepted, coins will refund";
      case RefundStatus.REFUSED:
        return "Your request is refused";
    }
  }

  String getIconPath() {
    switch (this) {
      case RefundStatus.PENDING:
        return AppPath.icRequestPending;
      case RefundStatus.ACCEPTED:
        return AppPath.icRequestAccepted;
      case RefundStatus.REFUSED:
        return AppPath.icRequestReject;
    }
  }
}
