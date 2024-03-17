import 'package:equatable/equatable.dart';
import 'package:shopfee/features/history/domain/entities/order_history_entity.dart';

class OrderHistoryGroupEntity extends Equatable {
  final List<OrderHistoryEntity> orderHistoryList;
  final int? page;
  final int? size;
  final bool isLoadMore;
  final bool cannotLoadMore;

  const OrderHistoryGroupEntity({
    this.orderHistoryList = const[],
    this.page,
    this.size,
    this.isLoadMore = false,
    this.cannotLoadMore= false,
  });

  OrderHistoryGroupEntity copyWith({
    List<OrderHistoryEntity>? orderHistoryList,
    int? page,
    int? size,
    bool? isLoadMore,
    bool? cannotLoadMore,
  }) {
    return OrderHistoryGroupEntity(
      orderHistoryList: orderHistoryList ?? this.orderHistoryList,
      page: page ?? this.page,
      size: size ?? this.size,
      isLoadMore: isLoadMore ?? this.isLoadMore,
      cannotLoadMore: cannotLoadMore ?? this.cannotLoadMore,
    );
  }

  @override
  List<Object?> get props => [
        orderHistoryList,
        page,
        size,
        isLoadMore,
        cannotLoadMore,
      ];
}
