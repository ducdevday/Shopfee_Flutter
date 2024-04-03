part of receipt;

extension ReceiptExtension on ReceiptLoadSuccess {
  bool showBottomAction() {
    if (showRequestReturnOrRefund() || showPayNowButton()) {
      return true;
    }
    return false;
  }

  bool showRequestReturnOrRefund() {
    if (lastEventLog.orderStatus == OrderStatus.SUCCEED &&
        lastEventLog.orderStatus == OrderStatus.CANCELED) {
      return true;
    }
    return false;
  }

  bool showPayNowButton() {
    if (lastEventLog.orderStatus == OrderStatus.CREATED &&
        receipt.transaction?.paymentUrl != null && receipt.transaction?.status == PaymentStatus.UNPAID) {
      return true;
    }
    return false;
  }
}
