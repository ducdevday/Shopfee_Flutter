import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shopfee/app/common/widgets/my_label.dart';
import 'package:shopfee/app/config/color.dart';
import 'package:shopfee/app/config/style.dart';
import 'package:shopfee/app/features/receipt/bloc/receipt_bloc.dart';
import 'package:shopfee/app/features/receipt/bloc/receipt_bloc.dart';
import 'package:shopfee/data/models/status_payment.dart';
import 'package:shopfee/data/models/type_payment.dart';

class PaymentSummary extends StatelessWidget {
  const PaymentSummary({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReceiptBloc, ReceiptState>(
      builder: (context, state) {
        if (state is ReceiptLoaded) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Payment Summary",
                      style: AppStyle.mediumTitleStyleDark
                          .copyWith(color: AppColor.headingColor)),
                ),
                SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Price",
                      style: AppStyle.normalTextStyleDark
                          .copyWith(fontWeight: FontWeight.w400),
                    ),
                    Text(
                      state.receipt.totalString,
                      style: AppStyle.normalTextStyleDark
                          .copyWith(fontWeight: FontWeight.w400),
                    )
                  ],
                ),
                SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Shipping fee",
                      style: AppStyle.normalTextStyleDark
                          .copyWith(fontWeight: FontWeight.w400),
                    ),
                    Text(
                      "0đ",
                      style: AppStyle.normalTextStyleDark
                          .copyWith(fontWeight: FontWeight.w400),
                    )
                  ],
                ),
                // SizedBox(
                //   height: 8,
                // ),
                // Row(
                //   mainAxisAlignment:
                //   MainAxisAlignment.spaceBetween,
                //   children: [
                //     Text(
                //       "Voucher",
                //       style: AppStyle
                //           .normalTextStyleDark
                //           .copyWith(
                //           fontWeight:
                //           FontWeight.w400),
                //     ),
                //     Text(
                //       "-30,000đ",
                //       style: AppStyle
                //           .normalTextStyleDark
                //           .copyWith(
                //           fontWeight:
                //           FontWeight.w400),
                //     )
                //   ],
                // ),
                SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Total",
                      style: AppStyle.mediumTitleStyleDark,
                    ),
                    Text(
                      state.receipt.totalString,
                      style: AppStyle.mediumTitleStyleDark,
                    )
                  ],
                ),
                Divider(
                  height: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Payment Method",
                      style: AppStyle.mediumTitleStyleDark.copyWith(
                          color: AppColor.headingColor,
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    buildPaymentMethod(state),
                  ],
                ),
                Divider(
                  height: 20,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Payment Status",
                        style: AppStyle.mediumTitleStyleDark.copyWith(
                            color: AppColor.headingColor,
                            fontWeight: FontWeight.w500),
                      ),
                      buildPaymentStatus(state),
                    ],
                  ),
                ),
                // Divider(
                //   height: 1,
                // ),
                // Align(
                //   alignment: Alignment.centerLeft,
                //   child: Column(
                //     crossAxisAlignment: CrossAxisAlignment.start,
                //     children: [
                //       SizedBox(height: 10,),
                //       Text(
                //         "Schedule Delivery",
                //         style: AppStyle.mediumTitleStyleDark.copyWith(
                //             color: AppColor.headingColor,
                //             fontWeight: FontWeight.w500),
                //       ),
                //       SizedBox(
                //         height: 4,
                //       ),
                //       Text("05:15 PM", style: AppStyle.normalTextStyleDark),
                //     ],
                //   ),
                // ),
              ],
            ),
          );
        } else {
          return SizedBox();
        }
      },
    );
  }

  StatelessWidget buildPaymentStatus(ReceiptLoaded state) {
    if (state.receipt.transaction!.status == StatusPayment.UNPAID) {
      return MyLabel(label: "Unpaid", color: AppColor.warning);
    } else if (state.receipt.transaction!.status == StatusPayment.PAID) {
      return MyLabel(label: "Paid", color: AppColor.success);
    } else if (state.receipt.transaction!.status == StatusPayment.REFUNDED) {
      return MyLabel(label: "Refunded", color: AppColor.info);
    }
    return SvgPicture.asset("assets/icons/ic_unpaid.svg");
  }

  Row buildPaymentMethod(ReceiptLoaded state) {
    if (state.receipt.transaction!.type == TypePayment.CASHING) {
      return Row(
        children: [
          Image.asset(
            "assets/icons/ic_cash.jpg",
            width: 24,
            height: 24,
          ),
          SizedBox(
            width: 4,
          ),
          Text("Cash", style: AppStyle.normalTextStyleDark),
        ],
      );
    } else {
      return Row(
        children: [
          Image.asset(
            "assets/icons/ic_vnpay.png",
            width: 24,
            height: 24,
          ),
          SizedBox(
            width: 4,
          ),
          Text("VNPay", style: AppStyle.normalTextStyleDark),
        ],
      );
    }
  }
}
