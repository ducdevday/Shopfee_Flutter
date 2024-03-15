part of receipt;

class LastStatusWidget extends StatelessWidget {
  final EventLogEntity lastEventLog;

  const LastStatusWidget({
    super.key,
    required this.lastEventLog,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
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
              FormatUtil.formatTime(lastEventLog.time),
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
                  OrderStatus.getFormattedName(lastEventLog.orderStatus),
                  style: AppStyle.mediumTextStyleDark
                      .copyWith(color: AppColor.primaryColor),
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  lastEventLog.descriptionString,
                  style: AppStyle.normalTextStyleDark,
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}