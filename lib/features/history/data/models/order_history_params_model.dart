import 'package:json_annotation/json_annotation.dart';
import 'package:shopfee/core/common/enum/history_status.dart';
import 'package:shopfee/features/history/domain/entities/order_history_params_entity.dart';

part 'order_history_params_model.g.dart';

@JsonSerializable()
class OrderHistoryParamsModel {
  @JsonKey(name: "order_phases_status")
  final String historyStatusName;
  final int page;
  final int size;

  const OrderHistoryParamsModel({
    required this.historyStatusName,
    required this.page,
    required this.size,
  });

  factory OrderHistoryParamsModel.fromJson(Map<String, dynamic> json) {
    return _$OrderHistoryParamsModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$OrderHistoryParamsModelToJson(this);
  }

  factory OrderHistoryParamsModel.fromEntity(OrderHistoryParamsEntity entity) {
    return OrderHistoryParamsModel(
      historyStatusName: entity.historyStatus.name,
      page: entity.page,
      size: entity.size,
    );
  }
}
