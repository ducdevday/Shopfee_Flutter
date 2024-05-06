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
  int giftListLength = 0;
  late String defaultText = "Show more";
  late Icon defaultIcon = const Icon(Icons.keyboard_arrow_down_rounded);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReceiptBloc, ReceiptState>(
      builder: (context, state) {
        if(state is ReceiptLoadSuccess && state.receipt.discountInformation?.productGiftList != null){
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Column(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Gift List",
                            style: AppStyle.mediumTitleStyleDark.copyWith(
                                color: AppColor.headingColor,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        ListView.separated(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: giftListLength < defaultLength
                              ? giftListLength
                              : maxLength,
                          itemBuilder: (context, index) {
                            return buildProductItem(state.receipt
                                .discountInformation!.productGiftList![index]);
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return const Divider(
                              height: 10,
                            );
                          },
                        )
                      ],
                    ),
                    Builder(builder: (context) {
                      if (defaultLength < giftListLength) {
                        return Column(
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            const Divider(
                              height: 1,
                            ),
                            Directionality(
                              textDirection: TextDirection.rtl,
                              child: TextButton.icon(
                                onPressed: () {
                                  if (maxLength == 3) {
                                    setState(() {
                                      maxLength = giftListLength;
                                      defaultText = "Show less";
                                      defaultIcon =
                                      const Icon(Icons.keyboard_arrow_up_rounded);
                                    });
                                  } else {
                                    setState(() {
                                      maxLength = 3;
                                      defaultText = "Show more";
                                      defaultIcon =
                                      const Icon(
                                          Icons.keyboard_arrow_down_rounded);
                                    });
                                  }
                                },
                                label: Text(defaultText),
                                icon: defaultIcon,
                              ),
                            ),
                          ],
                        );
                      } else {
                        return const Padding(padding: EdgeInsets.only(bottom: 8));
                      }
                    })
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
