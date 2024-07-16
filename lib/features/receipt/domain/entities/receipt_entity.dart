import 'package:shopfee/core/common/enum/refund_request_status.dart';
import 'package:shopfee/core/common/models/order_type.dart';
import 'package:shopfee/features/receipt/data/models/receipt_model.dart';
import 'package:shopfee/features/receipt/domain/entities/branch_entity.dart';
import 'package:shopfee/features/receipt/domain/entities/cashier_entity.dart';
import 'package:shopfee/features/receipt/domain/entities/discount_information_entity.dart';
import 'package:shopfee/features/receipt/domain/entities/receipt_product_entity.dart';
import 'package:shopfee/features/receipt/domain/entities/receiver_information_entity.dart';
import 'package:shopfee/features/receipt/domain/entities/transaction_entity.dart';

class ReceiptEntity {
  String? id;
  String? note;
  num? totalPayment;
  num? shippingFee;
  num? totalItemPrice;
  OrderType? orderType;
  ReceiverInformationEntity? receiverInformation;
  DateTime? createdAt;
  List<ReceiptProductEntity>? itemList;
  DiscountInformationEntity? discountInformation;
  TransactionEntity? transaction;
  BranchEntity? branch;
  int? coin;
  bool? needReview;
  RefundRequestStatus? refundRequestStatus;

  ReceiptEntity(
      {this.id,
      this.note,
      this.totalPayment,
      this.shippingFee,
      this.totalItemPrice,
      this.orderType,
      this.receiverInformation,
      this.createdAt,
      this.itemList,
      this.discountInformation,
      this.transaction,
      this.branch,
      this.coin,
      this.needReview,
      this.refundRequestStatus});

  factory ReceiptEntity.fromModel(ReceiptModel model) {
    return ReceiptEntity(
        id: model.id,
        note: model.note,
        totalPayment: model.totalPayment,
        shippingFee: model.shippingFee,
        totalItemPrice: model.totalItemPrice,
        orderType: model.orderType,
        receiverInformation: model.receiverInformation == null
            ? null
            : ReceiverInformationEntity.fromModel(model.receiverInformation!),
        createdAt: model.createdAt,
        itemList: model.itemList
            ?.map((e) => ReceiptProductEntity.fromModel(e))
            .toList(),
        discountInformation: model.discountInformation == null
            ? null
            : DiscountInformationEntity.fromModel(model.discountInformation!),
        transaction: model.transaction == null
            ? null
            : TransactionEntity.fromModel(model.transaction!),
        branch:
            model.branch == null ? null : BranchEntity.fromModel(model.branch!),
        coin: model.coin,
        needReview: model.needReview,
        refundRequestStatus: model.refundRequestStatus);
  }
}
