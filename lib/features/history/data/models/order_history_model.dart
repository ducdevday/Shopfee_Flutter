import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:shopfee/core/common/models/order_status.dart';
import 'package:shopfee/core/common/models/order_type.dart';

part 'order_history_model.g.dart';

@JsonSerializable()
class OrderHistoryModel {
  final String? id;
  final double? total;
  final OrderType? orderType;
  final String? productName;
  final int? productQuantity;
  final OrderStatus? statusLastEvent;
  final DateTime? timeLastEvent;

  const OrderHistoryModel({
    required this.id,
    required this.total,
    required this.orderType,
    required this.productName,
    required this.productQuantity,
    required this.statusLastEvent,
    required this.timeLastEvent,
  });

  factory OrderHistoryModel.fromJson(Map<String, dynamic> json) {
    return _$OrderHistoryModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$OrderHistoryModelToJson(this);
  }
}
