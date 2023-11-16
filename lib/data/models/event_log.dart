import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:shopfee/data/models/status_order.dart';

part 'event_log.g.dart';

@JsonSerializable()
class EventLog extends Equatable {
  final OrderStatus orderStatus;
  final DateTime time;
  final String? description;
  final bool? makerByEmployee;

  EventLog(this.orderStatus, this.time, this.description, this.makerByEmployee);

  String get descriptionString {
    if(description != null ){
      return description!;
    }
    else if(orderStatus == OrderStatus.CREATED){
      return "Your order was created. If after 10 minutes, order hasn't accepted, please call the hotline: 0334901237.";
    }
    else if(orderStatus == OrderStatus.ACCEPTED){
      return "Your order was accepted by employee. Please wait for us to process your order.";
    }
    else if(orderStatus == OrderStatus.DELIVERING){
      return "Your order is delivering. Please pay attention to your phone in case the shipper call you.";
    }
    else if(orderStatus == OrderStatus.SUCCEED){
      return "You have get your order. Thank you for choosing Shopfee.";
    }
    else if(orderStatus == OrderStatus.CANCELED){
      return "Your order was canceled.";
    }
    return "";
  }

  @override
  List<Object?> get props => [orderStatus, time, description];

  factory EventLog.fromJson(Map<String, dynamic> json) => _$EventLogFromJson(json);

  Map<String, dynamic> toJson() => _$EventLogToJson(this);


}
