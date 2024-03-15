enum OrderStatus {
  CREATED,
  ACCEPTED,
  CANCELLATION_REQUEST,
  CANCELLATION_REQUEST_REFUSED,
  CANCELLATION_REQUEST_ACCEPTED,
  DELIVERING,
  SUCCEED,
  CANCELED;

  String toJson() => name;

  static OrderStatus fromJson(String json) => values.byName(json);

  static List<String> orderStatusProcessing() =>
      ["Waiting for accepted", "Waiting for delivered", "Waiting for finished"];

  static List<String> orderStatusFinished() => ["Succeed", "Canceled"];

  static String? orderStatusAction(OrderStatus orderStatus) {
    if (orderStatus == OrderStatus.CREATED) {
      return "Accept";
    } else if (orderStatus == OrderStatus.ACCEPTED) {
      return "Delivery";
    }
    if (orderStatus == OrderStatus.DELIVERING) {
      return "Finish";
    }
    return null;
  }

  static String getFormattedName(OrderStatus? orderStatus) {
    switch (orderStatus) {
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
      case OrderStatus.DELIVERING:
        return "DELIVERING";
      case OrderStatus.SUCCEED:
        return "SUCCEED";
      case OrderStatus.CANCELED:
        return "CANCELED";
      default:
        return "";
    }
  }

  static OrderStatus? statusPreviousEvent(OrderStatus orderStatus) {
    if (orderStatus == OrderStatus.CANCELED) {
      return OrderStatus.CREATED;
    } else if (orderStatus == OrderStatus.ACCEPTED) {
      return OrderStatus.CREATED;
    }
    if (orderStatus == OrderStatus.DELIVERING) {
      return OrderStatus.ACCEPTED;
    }
    if (orderStatus == OrderStatus.SUCCEED) {
      return OrderStatus.DELIVERING;
    }
    return null;
  }
}
