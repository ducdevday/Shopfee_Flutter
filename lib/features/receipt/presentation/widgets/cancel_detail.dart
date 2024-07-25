part of receipt;

class CancelDetail extends StatelessWidget {
  const CancelDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReceiptBloc, ReceiptState>(
      builder: (context, state) {
        if (state is ReceiptLoadSuccess && state.getCancelDetail() != null) {
          state.getCancelDetail();
          return Column(
            children: [
              Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(R.canceledDetail.tr(),
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
                          R.requestBy.tr(),
                          style: AppStyle.normalTextStyleDark
                              .copyWith(fontWeight: FontWeight.w400),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          "${state.getCancelDetail()?.actor?.getFormattedName()}",
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
                          R.requestAt.tr(),
                          style: AppStyle.normalTextStyleDark
                              .copyWith(fontWeight: FontWeight.w400),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          "${FormatUtil.formatTime(state.getCancelDetail()?.time)} - ${FormatUtil.formatDate2(state.getCancelDetail()?.time)}",
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
                          R.reason.tr(),
                          style: AppStyle.normalTextStyleDark
                              .copyWith(fontWeight: FontWeight.w400),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          "${state.getCancelDetail()?.note ?? ""}",
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
