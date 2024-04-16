part of refund;

class RefundStatusWidget extends StatelessWidget {
  final RefundStatus status;

  const RefundStatusWidget({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              status.getFormattedName(),
              style: AppStyle.mediumTextStyleDark,
            ),
            Text(
              status.getResultString(),
              style: AppStyle.normalTextStyleDark,
            )
          ],
        )),
        Image.asset(
          status.getIconPath(),
          width: AppDimen.mediumSize,
          height: AppDimen.largeSize,
        )
      ],
    );
  }
}
