part of receipt;

class GiftList extends StatefulWidget {
  const GiftList({
    super.key,
  });

  @override
  State<GiftList> createState() => _GiftListState();
}

class _GiftListState extends State<GiftList> {
  late int defaultLength = 3;
  late int maxLength = 3;
  late int giftListLength;
  late String defaultText = "Show more";
  late Icon defaultIcon = const Icon(Icons.keyboard_arrow_down_rounded);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReceiptBloc, ReceiptState>(
      builder: (context, state) {
        if (state is ReceiptLoadSuccess &&
            state.receipt.discountInformation?.productGiftList != null) {
          giftListLength =
              state.receipt.discountInformation?.productGiftList!.length ?? 0;
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          R.giftList.tr(),
                          style: AppStyle.mediumTitleStyleDark.copyWith(
                              color: AppColor.headingColor,
                              fontWeight: FontWeight.w500),
                        ),
                        ListView.separated(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: giftListLength < defaultLength
                              ? giftListLength
                              : maxLength,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding:
                                  EdgeInsets.only(top: 4, bottom: 4, right: 8),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                            "${state.receipt.discountInformation?.productGiftList![index].name!}",
                                            style: AppStyle.mediumTitleStyleDark
                                                .copyWith(
                                                    color:
                                                        AppColor.headingColor)
                                                .copyWith(
                                                    fontWeight:
                                                        FontWeight.w500)),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              height: 6,
                                            ),
                                            Text(
                                              "${state.receipt.discountInformation?.productGiftList![index].quantity}x ${FormatUtil.formatSize(state.receipt.discountInformation?.productGiftList![index].size ?? "")}",
                                              style:
                                                  AppStyle.normalTextStyleDark,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return Divider(
                              height: 1,
                            );
                          },
                        ),
                      ],
                    ),
                    Builder(builder: (context) {
                      if (defaultLength < giftListLength) {
                        return Column(
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Divider(
                              height: 1,
                            ),
                            TextButton.icon(
                              onPressed: () {
                                if (maxLength == 3) {
                                  setState(() {
                                    maxLength = giftListLength;
                                    defaultText = R.showLess.tr();
                                    defaultIcon =
                                        Icon(Icons.keyboard_arrow_up_rounded);
                                  });
                                } else {
                                  setState(() {
                                    maxLength = 3;
                                    defaultText = R.showMore.tr();
                                    defaultIcon = Icon(
                                        Icons.keyboard_arrow_down_rounded);
                                  });
                                }
                              },
                              label: Text(defaultText),
                              icon: defaultIcon,
                            ),
                          ],
                        );
                      } else {
                        return SizedBox();
                      }
                    }),
                  ],
                ),
              ),
              Container(
                height: 4,
                color: AppColor.scaffoldColorBackground,
              ),
            ],
          );
        }
        return SizedBox();
      },
    );
  }

  Widget buildProductItem(ProductRewardEntity product) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("${product.name}",
            style: AppStyle.mediumTitleStyleDark
                .copyWith(color: AppColor.headingColor)
                .copyWith(fontWeight: FontWeight.w500)),
        const SizedBox(
          height: 6,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("${product.quantity} x "),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${product.size}",
                    style: AppStyle.normalTextStyleDark,
                  ),
                ],
              ),
            ),
          ],
        )
      ],
    );
  }
}
