part of receipt;

class PaymentSummary extends StatelessWidget {
  const PaymentSummary({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReceiptBloc, ReceiptState>(
      builder: (context, state) {
        if (state is ReceiptLoadSuccess) {
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
                const SizedBox(
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
                      FormatUtil.formatMoney(state.receipt.total),
                      style: AppStyle.normalTextStyleDark
                          .copyWith(fontWeight: FontWeight.w400),
                    )
                  ],
                ),
                const SizedBox(
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
                const SizedBox(
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
                      FormatUtil.formatMoney(state.receipt.total),
                      style: AppStyle.mediumTitleStyleDark,
                    )
                  ],
                ),
                const Divider(
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
                    const SizedBox(
                      height: 4,
                    ),
                    buildPaymentMethod(state),
                  ],
                ),
                const Divider(
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
          return const SizedBox();
        }
      },
    );
  }

  StatelessWidget buildPaymentStatus(ReceiptLoadSuccess state) {
    if (state.receipt.transaction!.status == PaymentStatus.UNPAID) {
      return MyLabel(label: "Unpaid", color: AppColor.warning);
    } else if (state.receipt.transaction!.status == PaymentStatus.PAID) {
      return MyLabel(label: "Paid", color: AppColor.success);
    } else if (state.receipt.transaction!.status == PaymentStatus.REFUNDED) {
      return MyLabel(label: "Refunded", color: AppColor.info);
    }
    return SvgPicture.asset(AppPath.icUnpaid);
  }

  Row buildPaymentMethod(ReceiptLoadSuccess state) {
    if (state.receipt.transaction!.type == PaymentType.CASHING) {
      return Row(
        children: [
          Image.asset(
            AppPath.icCash,
            width: 24,
            height: 24,
          ),
          const SizedBox(
            width: 4,
          ),
          Text("Cash", style: AppStyle.normalTextStyleDark),
        ],
      );
    } else {
      return Row(
        children: [
          Image.asset(
            AppPath.icVnPay,
            width: 24,
            height: 24,
          ),
          const SizedBox(
            width: 4,
          ),
          Text("VNPay", style: AppStyle.normalTextStyleDark),
        ],
      );
    }
  }
}
