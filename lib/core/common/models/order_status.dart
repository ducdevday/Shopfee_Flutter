enum OrderStatus {
  CREATED,
  ACCEPTED,
  DELIVERING,
  SUCCEED,
  CANCELED;

  String toJson() => name;

  static OrderStatus fromJson(String json) => values.byName(json);

  static List<String> orderStatusProcessing() => ["Waiting for accepted", "Waiting for delivered", "Waiting for finished"];
  static List<String> orderStatusFinished() => ["Succeed", "Canceled"];

  static String? orderStatusAction(OrderStatus orderStatus){
    if(orderStatus == OrderStatus.CREATED){
      return "Accept";
    }
    else if(orderStatus == OrderStatus.ACCEPTED){
      return "Delivery";
    }
    if(orderStatus == OrderStatus.DELIVERING){
      return "Finish";
    }
    return null;
  }

  static OrderStatus? statusPreviousEvent(OrderStatus orderStatus){
    if(orderStatus == OrderStatus.CANCELED){
      return OrderStatus.CREATED;
    }
    else if(orderStatus == OrderStatus.ACCEPTED){
      return OrderStatus.CREATED;
    }
    if(orderStatus == OrderStatus.DELIVERING){
      return OrderStatus.ACCEPTED;
    }
    if(orderStatus == OrderStatus.SUCCEED){
      return OrderStatus.DELIVERING;
    }
    return null;
  }


}

