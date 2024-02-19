import 'package:equatable/equatable.dart';
import 'package:shopfee/core/common/models/order_status.dart';
import 'package:shopfee/core/common/models/order_type.dart';
import 'package:shopfee/features/history/data/models/order_history_model.dart';

class OrderHistoryEntity extends Equatable {
  final String? id;
  final double? total;
  final OrderType? orderType;
  final String? productName;
  final int? productQuantity;
  final OrderStatus? statusLastEvent;
  final DateTime? timeLastEvent;

  const OrderHistoryEntity({
    required this.id,
    required this.total,
    required this.orderType,
    required this.productName,
    required this.productQuantity,
    required this.statusLastEvent,
    required this.timeLastEvent,
  });

  @override
  List<Object?> get props => [
        id,
        total,
        orderType,
        productName,
        productQuantity,
        statusLastEvent,
        timeLastEvent,
      ];

  factory OrderHistoryEntity.fromModel(OrderHistoryModel model) {
    return OrderHistoryEntity(
        id: model.id,
        total: model.total,
        orderType: model.orderType,
        productName: model.productName,
        productQuantity: model.productQuantity,
        statusLastEvent: model.statusLastEvent,
        timeLastEvent: model.timeLastEvent);
  }
}
