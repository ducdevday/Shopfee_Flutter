enum ReasonRefundType {
  NOT_RECEIVED,
  MISSING_PRODUCT,
  NOT_MATCH_DES,
  DAMAGED,
  WRONG_PRODUCT;

  String getString() {
    switch (this) {
      case ReasonRefundType.NOT_RECEIVED:
        return "Package has not been received";
      case ReasonRefundType.MISSING_PRODUCT:
        return "Missing products";
      case ReasonRefundType.NOT_MATCH_DES:
        return "Product does not match the description";
      case ReasonRefundType.DAMAGED:
        return "The product has been damaged";
      case ReasonRefundType.WRONG_PRODUCT:
        return "Wrong product sent";
    }
  }
}