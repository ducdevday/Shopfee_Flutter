part of receipt;

class CancelDetail extends StatelessWidget {
  const CancelDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReceiptBloc, ReceiptState>(
      builder: (context, state) {
        if (state is ReceiptLoadSuccess &&
            state.lastEventLog.orderStatus == OrderStatus.CANCELED) {
          return Column(
            children: [
              Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Canceled Detail",
                        style: AppStyle.mediumTitleStyleDark
                            .copyWith(color: AppColor.headingColor)),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          "Request by",
                          style: AppStyle.normalTextStyleDark
                              .copyWith(fontWeight: FontWeight.w400),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          "${state.lastEventLog.actor?.getFormattedName()}",
                          style: AppStyle.normalTextStyleDark
                              .copyWith(fontWeight: FontWeight.w400),
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
                          "Request at",
                          style: AppStyle.normalTextStyleDark
                              .copyWith(fontWeight: FontWeight.w400),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          "${FormatUtil.formatTime(state.lastEventLog.time)} - ${FormatUtil.formatDate2(state.lastEventLog.time)}",
                          style: AppStyle.normalTextStyleDark
                              .copyWith(fontWeight: FontWeight.w400),
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
                          "Reason",
                          style: AppStyle.normalTextStyleDark
                              .copyWith(fontWeight: FontWeight.w400),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          "${state.lastEventLog.description}",
                          style: AppStyle.normalTextStyleDark
                              .copyWith(fontWeight: FontWeight.w400),
                          textAlign: TextAlign.end,
                        ),
                      )
                    ],
                  ),
                ],
              ),
              const Divider(
                height: 20,
              ),
            ],
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
