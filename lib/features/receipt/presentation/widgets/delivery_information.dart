part of receipt;

class DeliveryInformation extends StatelessWidget {
  const DeliveryInformation({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReceiptBloc, ReceiptState>(builder: (context, state) {
      if (state is ReceiptLoadSuccess) {
        return Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Delivery Address",
                style: AppStyle.mediumTitleStyleDark.copyWith(
                    color: AppColor.headingColor, fontWeight: FontWeight.w500),
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
                      "${state.receipt.address?.recipientName}",
                      style: AppStyle.mediumTextStyleDark
                          .copyWith(color: AppColor.headingColor),
                    ),
                    Text(
                      "  |  ",
                      style: AppStyle.normalTextStyleDark,
                    ),
                    Text(
                      "${state.receipt.address?.phoneNumber}",
                      style: AppStyle.normalTextStyleDark,
                    ),
                  ],
                ),
                Text(
                  "${state.receipt.address?.detail}",
                  style: AppStyle.normalTextStyleDark,
                ),
              ],
            ),
          ],
        );
      }
      return SizedBox();
    });
  }
}
