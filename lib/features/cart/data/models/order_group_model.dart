import 'package:json_annotation/json_annotation.dart';
import 'package:shopfee/features/product_detail/data/models/order_model.dart';

part 'order_group_model.g.dart';

@JsonSerializable()
class OrderGroupModel {
  final String productId;
  final List<Map<String, dynamic>> itemDetailList;

  OrderGroupModel(this.productId, this.itemDetailList);

  static List<OrderGroupModel> groupOrders(List<OrderModel> orders) {
    Map<String, List<Map<String, dynamic>>> groupedOrders = {};

    for (var order in orders) {
      if (!groupedOrders.containsKey(order.product.id)) {
        groupedOrders[order.product.id!] = [];
      }

      groupedOrders[order.product.id!]!.add({
        'quantity': order.quantity,
        'toppingNameList': order.toppings.map((t) => t.name).toList(),
        'size': order.size?.size,
        'note': order.note,
      });
    }

    return groupedOrders.entries
        .map((entry) => OrderGroupModel(entry.key, entry.value))
        .toList();
  }

  Map<String, dynamic> toJson() {
    return _$OrderGroupModelToJson(this);
  }
}
