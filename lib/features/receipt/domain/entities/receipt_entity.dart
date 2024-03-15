import 'package:shopfee/core/common/models/order_type.dart';
import 'package:shopfee/features/receipt/data/models/receipt_model.dart';
import 'package:shopfee/features/receipt/domain/entities/receipt_product_entity.dart';
import 'package:shopfee/features/receipt/domain/entities/transaction_entity.dart';
import 'package:shopfee/features/saved_address/domain/entities/address_entity.dart';

class ReceiptEntity {
  String? id;
  String? note;
  num? totalPayment;
  num? shippingFee;
  num? totalItemPrice;
  OrderType? orderType;
  AddressEntity? address;
  DateTime? createdAt;
  List<ReceiptProductEntity>? itemList;
  TransactionEntity? transaction;
  String? branchAddress;

  ReceiptEntity({
    this.id,
    this.note,
    this.totalPayment,
    this.shippingFee,
    this.totalItemPrice,
    this.orderType,
    this.address,
    this.createdAt,
    this.itemList,
    this.transaction,
    this.branchAddress,
  });

  factory ReceiptEntity.fromModel(ReceiptModel model) {
    return ReceiptEntity(
        id: model.id,
        note: model.note,
        totalPayment: model.totalPayment,
        shippingFee: model.shippingFee,
        totalItemPrice: model.totalItemPrice,
        orderType: model.orderType,
        address: model.address == null
            ? null
            : AddressEntity.fromModel(model.address!),
        createdAt: model.createdAt,
        itemList: model.itemList
            ?.map((e) => ReceiptProductEntity.fromModel(e))
            .toList(),
        transaction: model.transaction == null
            ? null
            : TransactionEntity.fromModel(model.transaction!),
        branchAddress: model.branchAddress);
  }
}
