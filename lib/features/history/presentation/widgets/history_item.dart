part of history;

class HistoryItem extends StatelessWidget {
  final OrderHistoryEntity orderHistory;
  final bool isLastItem;

  const HistoryItem({required this.orderHistory, required this.isLastItem});

  String buildShowMoreString(num? productQuantity) {
    return productQuantity == null
        ? ""
        : productQuantity - 1 > 1
            ? "Show more ${productQuantity - 1} items"
            : "Show more ${productQuantity - 1} item";
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: AppDimen.screenPadding),
          child: Row(children: [
            SvgPicture.asset(
              orderHistory.orderType == OrderType.SHIPPING
                  ? AppPath.icDelivery
                  : AppPath.icTakeAway,
              width: 70,
              height: 70,
            ),
            const SizedBox(
              width: 4,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        orderHistory.productName ?? "",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppStyle.mediumTextStyleDark.copyWith(
                          color: AppColor.headingColor,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    "${FormatUtil.formatTime(orderHistory.timeLastEvent)} - ${FormatUtil.formatDate(orderHistory.timeLastEvent)}",
                    style: AppStyle.normalTextStyleDark,
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    OrderStatus.getFormattedName(orderHistory.statusLastEvent),
                    style: AppStyle.smallTextStyleDark.copyWith(
                      color: getBadgeColor(), fontWeight: FontWeight.w500
                    ),
                  )
                ],
              ),
            ),
            Text(
              FormatUtil.formatMoney(orderHistory.total),
              style: AppStyle.mediumTextStyleDark.copyWith(
                color: AppColor.headingColor.withOpacity(0.95),
              ),
            )
          ]),
        ),
        if (orderHistory.productQuantity != null &&
            orderHistory.productQuantity! > 1)
          Column(
            children: [
              const Divider(
                height: 10,
                indent: AppDimen.screenPadding,
              ),
              Text(
                buildShowMoreString(orderHistory.productQuantity),
                style: AppStyle.smallTextStyleDark,
              ),
              if (isLastItem)
                const Divider(
                  height: 10,
                  thickness: 1,
                ),
            ],
          )
      ],
    );
  }

  Color getBadgeColor() {
    if (orderHistory.statusLastEvent == OrderStatus.SUCCEED) {
      return AppColor.success;
    } else if (orderHistory.statusLastEvent == OrderStatus.CANCELED) {
      return AppColor.error;
    }
    return AppColor.primaryColor;
  }
}
