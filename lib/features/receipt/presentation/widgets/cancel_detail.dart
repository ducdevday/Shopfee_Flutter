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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Request by",
                        style: AppStyle.normalTextStyleDark
                            .copyWith(fontWeight: FontWeight.w400),
                      ),
                      Text(
                        state.lastEventLog.makerByEmployee!
                            ? "Employee"
                            : "Customer",
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
                        "Request at",
                        style: AppStyle.normalTextStyleDark
                            .copyWith(fontWeight: FontWeight.w400),
                      ),
                      Text(
                        "${FormatUtil.formatTime(state.lastEventLog.time)} - ${FormatUtil.formatDate2(state.lastEventLog.time)}",
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Reason",
                        style: AppStyle.normalTextStyleDark
                            .copyWith(fontWeight: FontWeight.w400),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width / 2,
                        child: Text(
                          "${state.lastEventLog.description}",
                          style: AppStyle.normalTextStyleDark
                              .copyWith(fontWeight: FontWeight.w400),
                          textAlign: TextAlign.right,
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
