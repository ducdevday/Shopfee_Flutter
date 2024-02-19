part of receipt;

class DeliveryInformation extends StatelessWidget {
  const DeliveryInformation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReceiptBloc, ReceiptState>(
      builder: (context, state) {
        if (state is ReceiptLoadSuccess) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Delivery Information",
                      style: AppStyle.mediumTitleStyleDark.copyWith(
                          color: AppColor.headingColor,
                          fontWeight: FontWeight.w500),
                    ),
                    InkWell(
                        onTap: () {
                          NavigationUtil.pushNamed(TrackingPage.route,
                              arguments: state.receipt.id);
                        },
                        child: Text("More",
                            style: AppStyle.mediumTextStyleDark
                                .copyWith(color: AppColor.primaryColor)))
                  ],
                ),
                Row(
                  children: [
                    Column(
                      children: [
                        Icon(
                          Icons.circle,
                          color: AppColor.primaryColor,
                          size: 10,
                        ),
                        const SizedBox(
                          height: 2,
                        ),
                        Text(
                          FormatUtil.formattedTime(state.lastEventLog.time),
                          style: AppStyle.smallTextStyleDark,
                        ),
                      ],
                    ),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${state.lastEventLog.orderStatus?.name}",
                              style: AppStyle.mediumTextStyleDark
                                  .copyWith(color: AppColor.primaryColor),
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            Text(
                              state.lastEventLog.descriptionString,
                              style: AppStyle.normalTextStyleDark,
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                const Divider(
                  height: 20,
                ),
                const CancelButton(),
                const CancelDetail(),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Delivery Address",
                    style: AppStyle.mediumTitleStyleDark.copyWith(
                        color: AppColor.headingColor,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          state.receipt.address!.recipientName ?? "",
                          style: AppStyle.mediumTextStyleDark
                              .copyWith(color: AppColor.headingColor),
                        ),
                        Text(
                          "  |  ",
                          style: AppStyle.normalTextStyleDark,
                        ),
                        Text(
                          state.receipt.address!.phoneNumber ?? "",
                          style: AppStyle.normalTextStyleDark,
                        ),
                      ],
                    ),
                    Text(
                      state.receipt.address!.details ?? "",
                      style: AppStyle.normalTextStyleDark,
                    ),
                  ],
                ),
              ],
            ),
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
