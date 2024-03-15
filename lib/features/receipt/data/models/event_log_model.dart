import 'package:json_annotation/json_annotation.dart';
import 'package:shopfee/core/common/models/order_status.dart';
import 'package:shopfee/features/receipt/domain/entities/event_log_entity.dart';

part 'event_log_model.g.dart';

@JsonSerializable()
class EventLogModel {
  final OrderStatus? orderStatus;
  @JsonKey(name: "createdAt")
  final DateTime? time;
  final String? description;
  @JsonKey(name: "employee")
  final bool? makerByEmployee;

  const EventLogModel({
    this.orderStatus,
    this.time,
    this.description,
    this.makerByEmployee,
  });

  factory EventLogModel.fromJson( Map<String, dynamic> json) {
    return _$EventLogModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$EventLogModelToJson(this);
  }

  factory EventLogModel.fromEntity(EventLogEntity entity) {
    return EventLogModel(
        orderStatus: entity.orderStatus,
        time: entity.time,
        description: entity.description,
        makerByEmployee: entity.makerByEmployee);
  }
}
