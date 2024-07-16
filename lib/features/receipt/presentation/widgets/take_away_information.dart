part of receipt;

class TakeAwayInformation extends StatelessWidget {
  const TakeAwayInformation({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReceiptBloc, ReceiptState>(builder: (context, state) {
      if (state is ReceiptLoadSuccess) {
        if (state.receipt.orderType == OrderType.ONSITE) {
          return Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Receiver Information",
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
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Take Away In",
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
                      Image.asset(AppPath.icStoreMark, width: AppDimen.xSmallSize,height: AppDimen.xSmallSize,),
                      SizedBox(width: AppDimen.smallSpacing,),
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
                  SizedBox(height: AppDimen.spacing,),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(AppPath.icClock, width: AppDimen.xSmallSize,height: AppDimen.xSmallSize,),
                      SizedBox(width: AppDimen.smallSpacing,),
                      Expanded(
                        child: Text(
                          "Chosen Time: ${FormatUtil.formatTime(state.receipt.receiverInformation?.receiveTime)} - ${FormatUtil.formatDate2(state.receipt.receiverInformation?.receiveTime)}",
                          style: AppStyle.normalTextStyleDark,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          );
        }
      }
      return SizedBox();
    });
  }
}
