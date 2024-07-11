import 'package:shopfee/core/common/models/order_status.dart';

extension OrderStatusExtension on OrderStatus{
  String getFormattedName() {
    switch (this) {
      case OrderStatus.CREATED:
        return "CREATED";
      case OrderStatus.ACCEPTED:
        return "ACCEPTED";
      case OrderStatus.CANCELLATION_REQUEST:
        return "REQUEST CANCEL IN PROCESS";
      case OrderStatus.CANCELLATION_REQUEST_REFUSED:
        return "REQUEST CANCEL REFUSED";
      case OrderStatus.CANCELLATION_REQUEST_ACCEPTED:
        return "REQUEST CANCEL ACCEPTED";
      case OrderStatus.PENDING_PICK_UP:
        return "PREPARED";
      case OrderStatus.IN_DELIVERY:
        return "DELIVERING";
      case OrderStatus.NOT_RECEIVED:
        return "NOT RECEIVED";
      case OrderStatus.SUCCEED:
        return "SUCCEED";
      case OrderStatus.CANCELED:
        return "CANCELED";
    }
  }
}