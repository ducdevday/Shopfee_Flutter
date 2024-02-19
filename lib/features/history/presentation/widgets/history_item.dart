part of history;

class HistoryItem extends StatelessWidget {
  final int index;

  const HistoryItem({
    super.key,
    required this.index,
  });

  String buildShowMoreString(num? productQuantity) {
    return productQuantity == null
        ? ""
        : productQuantity - 1 > 1
            ? "Show more ${productQuantity - 1} items"
            : "Show more ${productQuantity - 1} item";
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HistoryBloc, HistoryState>(
      builder: (context, state) {
        if (state is HistoryLoaded) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: AppDimen.screenPadding),
                child: Row(children: [
                  Builder(builder: (context) {
                    if (state.orderHistoryList[index].orderType ==
                        OrderType.SHIPPING) {
                      return SvgPicture.asset(
                        AppPath.icDelivery ,
                        width: 70,
                        height: 70,
                      );
                    } else {
                      return SvgPicture.asset(
                        AppPath.icTakeAway ,
                        width: 70,
                        height: 70,
                      );
                    }
                  }),
                  const SizedBox(
                    width: 4,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                state.orderHistoryList[index].productName ?? "",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: AppStyle.mediumTextStyleDark.copyWith(
                                  color: AppColor.headingColor,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Builder(builder: (context) {
                              if (state.orderHistoryList[index]
                                      .statusLastEvent ==
                                  OrderStatus.SUCCEED) {
                                return Text(
                                    state.orderHistoryList[index]
                                            .statusLastEvent?.name ??
                                        "",
                                    style: AppStyle.mediumTextStyleDark
                                        .copyWith(color: AppColor.success));
                              } else if (state.orderHistoryList[index]
                                      .statusLastEvent ==
                                  OrderStatus.CANCELED) {
                                return Text(
                                    state.orderHistoryList[index]
                                            .statusLastEvent?.name ??
                                        "",
                                    style: AppStyle.mediumTextStyleDark
                                        .copyWith(color: AppColor.error));
                              }
                              return Text(
                                state.orderHistoryList[index].statusLastEvent
                                        ?.name ??
                                    "",
                                style: AppStyle.mediumTextStyleDark
                                    .copyWith(color: AppColor.primaryColor),
                              );
                            }),
                          ],
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Text(
                          "${FormatUtil.formattedTime(state.orderHistoryList[index].timeLastEvent)} - ${FormatUtil.formattedDate(state.orderHistoryList[index].timeLastEvent)}",
                          style: AppStyle.normalTextStyleDark,
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Text(
                          "Total: ${FormatUtil.formatMoney(state.orderHistoryList[index].total)}",
                          style: AppStyle.mediumTextStyleDark.copyWith(
                            color: AppColor.headingColor.withOpacity(0.95),
                          ),
                        ),
                      ],
                    ),
                  ),
                ]),
              ),
              Builder(builder: (context) {
                if (state.orderHistoryList[index].productQuantity != null &&
                    state.orderHistoryList[index].productQuantity! > 1) {
                  if (index == state.orderHistoryList.length - 1) {
                    return Column(
                      children: [
                        const Divider(
                          height: 10,
                          indent: AppDimen.screenPadding,
                        ),
                        Text(
                          buildShowMoreString(
                              state.orderHistoryList[index].productQuantity),
                          style: AppStyle.smallTextStyleDark,
                        ),
                        const Divider(
                          height: 10,
                          thickness: 1,
                        ),
                      ],
                    );
                  } else {
                    return Column(
                      children: [
                        const Divider(
                          height: 10,
                          indent: AppDimen.screenPadding,
                        ),
                        Text(
                          buildShowMoreString(
                              state.orderHistoryList[index].productQuantity),
                          style: AppStyle.smallTextStyleDark,
                        )
                      ],
                    );
                  }
                } else {
                  return const SizedBox();
                }
              })
            ],
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
