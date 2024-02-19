import 'package:shopfee/core/common/models/order_type.dart';
import 'package:shopfee/features/receipt/data/models/receipt_model.dart';
import 'package:shopfee/features/receipt/domain/entities/receipt_product_entity.dart';
import 'package:shopfee/features/receipt/domain/entities/transaction_entity.dart';
import 'package:shopfee/features/saved_address/data/models/address_model.dart';
import 'package:shopfee/features/saved_address/domain/entities/address_entity.dart';

class ReceiptEntity {
  String? id;
  String? note;
  double? total;
  OrderType? orderType;
  AddressEntity? address;
  DateTime? createdAt;
  List<ReceiptProductEntity>? products;
  TransactionEntity? transaction;

  // Review? review;

  ReceiptEntity({
    this.id,
    this.note,
    this.total,
    this.orderType,
    this.address,
    this.createdAt,
    this.products,
    this.transaction,
    // this.review
  });

  factory ReceiptEntity.fromModel(ReceiptModel model) {
    return ReceiptEntity(
        id: model.id,
        note: model.note,
        total: model.total,
        orderType: model.orderType,
        address: model.address == null
            ? null
            : AddressEntity.fromModel(model.address!),
        createdAt: model.createdAt,
        products: model.products
            ?.map((e) => ReceiptProductEntity.fromModel(e))
            .toList(),
        transaction: model.transaction == null
            ? null : TransactionEntity.fromModel(model.transaction!));
  }
}
