part of receipt;

class DeliveryInformation extends StatelessWidget {
  const DeliveryInformation({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReceiptBloc, ReceiptState>(builder: (context, state) {
      if (state is ReceiptLoadSuccess) {
        if (state.receipt.orderType == OrderType.SHIPPING) {
          return Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Delivery To",
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
                      const Icon(
                        Icons.account_circle_outlined,
                        size: 20,
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      Text(
                        "${state.receipt.receiverInformation?.recipientName}",
                        style: AppStyle.mediumTextStyleDark
                            .copyWith(color: AppColor.headingColor),
                      ),
                      Text(
                        "  |  ",
                        style: AppStyle.normalTextStyleDark,
                      ),
                      Text(
                        "${state.receipt.receiverInformation?.phoneNumber}",
                        style: AppStyle.normalTextStyleDark,
                      ),
                    ],
                  ),
                  Text(
                    "${state.receipt.receiverInformation?.detail}",
                    style: AppStyle.normalTextStyleDark,
                  ),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Store Information",
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(
                        AppPath.icStoreMark,
                        width: AppDimen.xSmallSize,
                        height: AppDimen.xSmallSize,
                      ),
                      SizedBox(
                        width: AppDimen.smallSpacing,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Shopfee ${state.receipt.branch?.address}",
                              style: AppStyle.normalTextStyleDark,
                            ),
                            Text(
                              "ID: ${state.receipt.branch?.id}",
                              style: AppStyle.normalTextStyleDark,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              )
            ],
          );
        }
      }
      return SizedBox();
    });
  }
}
