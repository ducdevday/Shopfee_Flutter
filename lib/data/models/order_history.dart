import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:shopfee/data/models/order_type.dart';
import 'package:shopfee/data/models/status_order.dart';

part 'order_history.g.dart';

@JsonSerializable()
class OrderHistory extends Equatable {
  final String id;
  final double total;
  final OrderType orderType;
  final String productName;
  final int productQuantity;
  final OrderStatus statusLastEvent;
  final DateTime timeLastEvent;

  OrderHistory({
    required this.id,
    required this.total,
    required this.orderType,
    required this.productName,
    required this.productQuantity,
    required this.statusLastEvent,
    required this.timeLastEvent,
  });

  String get showMoreString => productQuantity - 1 > 1
      ? "Show more ${productQuantity - 1} items"
      : "Show more ${productQuantity - 1} item";

  String get totalPriceString =>
      "${NumberFormat.decimalPattern().format(total)}đ";

  @override
  List<Object> get props => [
        id,
        total,
        orderType,
        statusLastEvent,
        timeLastEvent,
      ];

  factory OrderHistory.fromJson(Map<String, dynamic> json) =>
      _$OrderHistoryFromJson(json);

  Map<String, dynamic> toJson() => _$OrderHistoryToJson(this);
}
