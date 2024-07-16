part of receipt;

class ReceiptInformation extends StatelessWidget {
  const ReceiptInformation({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: BlocBuilder<ReceiptBloc, ReceiptState>(
        builder: (context, state) {
          if (state is ReceiptLoadSuccess) {
            return Column(
              children: [
                const SizedBox(
                  height: 40,
                ),
                Builder(builder: (context) {
                  if (state.lastEventLog.orderStatus ==
                      OrderStatus.NOT_RECEIVED) {
                    return Column(
                      children: [
                        Text(
                          "See you again!",
                          style: AppStyle.largeTitleStylePrimary,
                        ),
                        // const SizedBox(
                        //   height: 8,
                        // ),
                        // Builder(builder: (context) {
                        //   if (state.lastEventLog.orderStatus !=
                        //       OrderStatus.SUCCEED) {
                        //     return Text(
                        //       "Your order in processing",
                        //       style: AppStyle.mediumTextStyleDark,
                        //     );
                        //   } else {
                        //     return Text(
                        //       "Your order was succeed",
                        //       style: AppStyle.mediumTextStyleDark,
                        //     );
                        //   }
                        // }),
                      ],
                    );
                  } else if (state.lastEventLog.orderStatus ==
                      OrderStatus.CANCELED) {
                    return Column(
                      children: [
                        Text(
                          "Oops!",
                          style: AppStyle.largeTitleStylePrimary,
                        ),
                        // const SizedBox(
                        //   height: 8,
                        // ),
                        // Text(
                        //   "Your order was canceled",
                        //   style: AppStyle.mediumTextStyleDark,
                        // ),
                      ],
                    );
                  } else {
                    return Column(
                      children: [
                        Text(
                          "Thank you!",
                          style: AppStyle.largeTitleStylePrimary,
                        ),
                        // const SizedBox(
                        //   height: 8,
                        // ),
                        // Builder(builder: (context) {
                        //   if (state.lastEventLog.orderStatus !=
                        //       OrderStatus.SUCCEED) {
                        //     return Text(
                        //       "Your order in processing",
                        //       style: AppStyle.mediumTextStyleDark,
                        //     );
                        //   } else {
                        //     return Text(
                        //       "Your order was succeed",
                        //       style: AppStyle.mediumTextStyleDark,
                        //     );
                        //   }
                        // }),
                      ],
                    );
                  }
                }),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        "ID Transaction",
                        style: AppStyle.mediumTitleStyleDark,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        state.receipt.id!,
                        style: AppStyle.normalTextStyleDark,
                        textAlign: TextAlign.end,
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        "Date",
                        style: AppStyle.mediumTitleStyleDark,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        FormatUtil.formatDate(state.receipt.createdAt),
                        style: AppStyle.normalTextStyleDark,
                        textAlign: TextAlign.end,
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        "Time",
                        style: AppStyle.mediumTitleStyleDark,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        FormatUtil.formatTime(state.receipt.createdAt),
                        style: AppStyle.normalTextStyleDark,
                        textAlign: TextAlign.end,
                      ),
                    )
                  ],
                ),
              ],
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}
