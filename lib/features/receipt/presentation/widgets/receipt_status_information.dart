part of receipt;

class ReceiptStatusInformation extends StatelessWidget {
  final String orderId;

  const ReceiptStatusInformation({Key? key, required this.orderId})
      : super(key: key);

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
                      R.statusInformatinon.tr(),
                      style: AppStyle.mediumTitleStyleDark.copyWith(
                          color: AppColor.headingColor,
                          fontWeight: FontWeight.w500),
                    ),
                    InkWell(
                        onTap: () {
                          NavigationUtil.pushNamed(TrackingPage.route,
                              arguments: state.receipt.id);
                        },
                        child: Text(R.more.tr(),
                            style: AppStyle.mediumTextStyleDark
                                .copyWith(color: AppColor.primaryColor)))
                  ],
                ),
                LastStatusWidget(
                  lastEventLog: state. lastEventLog,
                ),
                const Divider(
                  height: 20,
                ),
                const CancelButton(),
                ReviewSummary(
                  orderId: orderId,
                ),
                const CancelDetail(),
                const DeliveryInformation(),
                const TakeAwayInformation()
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
