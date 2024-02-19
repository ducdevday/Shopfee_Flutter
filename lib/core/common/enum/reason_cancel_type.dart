enum ReasonCancelType {
  UPDATE_ADDRESS,
  UPDATE_PRODUCT,
  NO_BUY,
  ORDER_REASON;

  static String getString(ReasonCancelType? type) {
    switch (type) {
      case ReasonCancelType.UPDATE_ADDRESS:
        return "I want to update address";
      case ReasonCancelType.UPDATE_PRODUCT:
        return "I want to update products";
      case ReasonCancelType.NO_BUY:
        return "I don't want to buy anymore";
      case ReasonCancelType.ORDER_REASON:
        return "I couldn't find a reasonable reason to cancel";
      case null:
       return "";
      default:
        return "";
    }
  }

  // static PaymentType fromJson(String json) => values.byName(json);
}
