part of coin;

class CoinHistoryItem extends StatelessWidget {
  final CoinHistoryEntity coinHistory;

  const CoinHistoryItem({super.key, required this.coinHistory});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.asset(
          AppPath.icCoin,
          width: AppDimen.largeSize,
          height: AppDimen.largeSize,
        ),
        SizedBox(
          width: AppDimen.spacing,
        ),
        Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${coinHistory.description}",
              style: AppStyle.mediumTextStyleDark,
            ),
            SizedBox(height: AppDimen.smallSpacing,),
            Text(
              "${FormatUtil.formatTime(coinHistory.createdAt)} - ${FormatUtil.formatDate2(coinHistory.createdAt)}",
              style: AppStyle.normalTextStyleDark,
            )
          ],
        )),
        SizedBox(
          width: AppDimen.spacing,
        ),
        Text(
          "${coinHistory.coin}",
          style: AppStyle.mediumTextStyleDark.copyWith(color: coinHistory.coin! > 0 ? AppColor.rating : AppColor.nonactiveColor ),
        )
      ],
    );
  }
}
