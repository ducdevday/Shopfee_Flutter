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
                  if (state.lastEventLog.orderStatus != OrderStatus.CANCELED) {
                    return Column(
                      children: [
                        Text(
                          "Thank you!",
                          style: AppStyle.largeTitleStylePrimary,
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Builder(builder: (context) {
                          if (state.lastEventLog.orderStatus !=
                              OrderStatus.SUCCEED) {
                            return Text(
                              "Your order in processing",
                              style: AppStyle.mediumTextStyleDark,
                            );
                          } else {
                            return Text(
                              "Your order was succeed",
                              style: AppStyle.mediumTextStyleDark,
                            );
                          }
                        }),
                      ],
                    );
                  } else {
                    return Column(
                      children: [
                        Text(
                          "Oops!",
                          style: AppStyle.largeTitleStylePrimary,
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                          "Your order was canceled",
                          style: AppStyle.mediumTextStyleDark,
                        ),
                      ],
                    );
                  }
                }),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "ID Transaction",
                      style: AppStyle.mediumTitleStyleDark,
                    ),
                    Text(
                      state.receipt.id!,
                      style: AppStyle.normalTextStyleDark,
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
                      "Date",
                      style: AppStyle.mediumTitleStyleDark,
                    ),
                    Text(
                      FormatUtil.formatDate(state.receipt.createdAt),
                      style: AppStyle.normalTextStyleDark,
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
                      "Time",
                      style: AppStyle.mediumTitleStyleDark,
                    ),
                    Text(
                      FormatUtil.formatTime(state.receipt.createdAt),
                      style: AppStyle.normalTextStyleDark,
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
