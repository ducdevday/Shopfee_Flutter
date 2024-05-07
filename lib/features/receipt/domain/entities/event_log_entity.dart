import 'package:equatable/equatable.dart';
import 'package:shopfee/core/common/enum/actor_type.dart';
import 'package:shopfee/core/common/extensions/actor_type_extension.dart';
import 'package:shopfee/core/common/models/order_status.dart';
import 'package:shopfee/features/receipt/data/models/event_log_model.dart';

class EventLogEntity extends Equatable {
  final OrderStatus? orderStatus;
  final DateTime? time;
  final String? description;
  final String? note;
  final ActorType? actor;

  const EventLogEntity({
    this.orderStatus,
    this.time,
    this.description,
    this.note,
    this.actor,
  });

  String get descriptionString {
    // if (description != null && description!.isNotEmpty) {
    if (description != null) {
      return description!;
    } else if (orderStatus == OrderStatus.CREATED) {
      return "Your order was created. If after 10 minutes, order hasn't accepted, please call the hotline: 0334901237.";
    } else if (orderStatus == OrderStatus.ACCEPTED) {
      return "Your order was accepted by ${actor?.getFormattedName()}. Please wait for us to process your order.";
    } else if (orderStatus == OrderStatus.PREPARED) {
      return "Your order was prepared";
    } else if (orderStatus == OrderStatus.DELIVERING) {
      return "Your order is delivering. Please pay attention to your phone in case the shipper call you.";
    } else if (orderStatus == OrderStatus.SUCCEED) {
      return "You have get your order. Thank you for choosing Shopfee.";
    } else if (orderStatus == OrderStatus.CANCELED) {
      return "Your order was canceled.";
    } else if (orderStatus == OrderStatus.NOT_RECEIVED) {
      return "Your order was mark as boom";
    }
    return "";
  }

  @override
  List<Object?> get props => [orderStatus, time, description, actor];

  factory EventLogEntity.fromModel(EventLogModel model) {
    return EventLogEntity(
        orderStatus: model.orderStatus,
        time: model.time,
        description: model.description,
        note: model.note,
        actor: model.actor);
  }
}
