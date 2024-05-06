part of receipt;

extension ReceiptExtension on ReceiptLoadSuccess {
  bool showBottomAction() {
    if (showRequestRefund() || showPayNowButton()) {
      return true;
    }
    return false;
  }

  EventLogEntity? getCancelDetail() {
    final statusList = eventLogs.map((e) => e.orderStatus).toList();
    final indexOfCancelRequest =
        statusList.indexOf(OrderStatus.CANCELLATION_REQUEST);
    final indexOfCancel = statusList.indexOf(OrderStatus.CANCELED);
    final indexOfSuccess = statusList.indexOf(OrderStatus.SUCCEED);
    final indexOfNotReceive = statusList.indexOf(OrderStatus.NOT_RECEIVED);

    if (indexOfSuccess != -1) {
      return null;
    } else if (indexOfNotReceive != -1) {
      return null;
    } else if (indexOfCancelRequest != -1 && indexOfCancel != -1) {
      return eventLogs.elementAt(indexOfCancelRequest);
    } else if (indexOfCancel != -1) {
      return eventLogs.elementAt(indexOfCancel);
    }
    return null;
  }

  bool showRequestRefund() {
    if (lastEventLog.orderStatus == OrderStatus.SUCCEED &&
        receipt.refundRequestStatus != RefundRequestStatus.NOT_REFUND) {
      return true;
    }
    return false;
  }

  bool showPayNowButton() {
    if (lastEventLog.orderStatus == OrderStatus.CREATED &&
        receipt.transaction?.paymentUrl != null &&
        receipt.transaction?.status == PaymentStatus.UNPAID) {
      return true;
    }
    return false;
  }
}
