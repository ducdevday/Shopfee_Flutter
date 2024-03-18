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
  AddressEntity? shippingInformation;
  DateTime? createdAt;
  List<ReceiptProductEntity>? itemList;
  TransactionEntity? transaction;
  DateTime? receiveTime;
  String? branchAddress;
  int? coin;

  ReceiptEntity({
    this.id,
    this.note,
    this.totalPayment,
    this.shippingFee,
    this.totalItemPrice,
    this.orderType,
    this.shippingInformation,
    this.createdAt,
    this.itemList,
    this.transaction,
    this.receiveTime,
    this.branchAddress,
    this.coin,
  });

  factory ReceiptEntity.fromModel(ReceiptModel model) {
    return ReceiptEntity(
        id: model.id,
        note: model.note,
        totalPayment: model.totalPayment,
        shippingFee: model.shippingFee,
        totalItemPrice: model.totalItemPrice,
        orderType: model.orderType,
        shippingInformation: model.shippingInformation == null
            ? null
            : AddressEntity.fromModel(model.shippingInformation!),
        createdAt: model.createdAt,
        itemList: model.itemList
            ?.map((e) => ReceiptProductEntity.fromModel(e))
            .toList(),
        transaction: model.transaction == null
            ? null
            : TransactionEntity.fromModel(model.transaction!),
        receiveTime: model.receiveTime,
        branchAddress: model.branchAddress,
        coin: model.coin);
  }
}
