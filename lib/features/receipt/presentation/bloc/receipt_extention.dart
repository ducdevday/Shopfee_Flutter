part of receipt;

extension ReceiptExtension on ReceiptLoadSuccess {
  bool showBottomAction() {
    if (showRequestRefund() || showPayNowButton()) {
      return true;
    }
    return false;
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
