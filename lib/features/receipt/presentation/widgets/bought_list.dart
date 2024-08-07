part of receipt;

class BoughtList extends StatefulWidget {
  const BoughtList({
    super.key,
  });

  @override
  State<BoughtList> createState() => _BoughtListState();
}

class _BoughtListState extends State<BoughtList> {
  late int defaultLength = 3;
  late int maxLength = 3;
  late int boughtListLength;
  late String defaultText = R.showMore.tr();
  late Icon defaultIcon = const Icon(Icons.keyboard_arrow_down_rounded);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  R.boughtList.tr(),
                  style: AppStyle.mediumTitleStyleDark.copyWith(
                      color: AppColor.headingColor,
                      fontWeight: FontWeight.w500),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              BlocBuilder<ReceiptBloc, ReceiptState>(
                builder: (context, state) {
                  if (state is ReceiptLoadSuccess) {
                    boughtListLength = state.receipt.itemList!.length;
                    return ListView.separated(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: boughtListLength < defaultLength
                          ? boughtListLength
                          : maxLength,
                      itemBuilder: (context, index) {
                        return buildProductItem(state.receipt.itemList![index]);
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return const Divider(
                          height: 10,
                        );
                      },
                    );
                  } else {
                    return const SizedBox();
                  }
                },
              ),
            ],
          ),
          Builder(builder: (context) {
            if (defaultLength < boughtListLength) {
              return Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  const Divider(
                    height: 1,
                  ),
                  TextButton.icon(
                    onPressed: () {
                      if (maxLength == 3) {
                        setState(() {
                          maxLength = boughtListLength;
                          defaultText = R.showLess.tr();
                          defaultIcon =
                              const Icon(Icons.keyboard_arrow_up_rounded);
                        });
                      } else {
                        setState(() {
                          maxLength = 3;
                          defaultText = R.showMore.tr();
                          defaultIcon =
                              const Icon(Icons.keyboard_arrow_down_rounded);
                        });
                      }
                    },
                    label: Text(defaultText),
                    icon: defaultIcon,
                  ),
                ],
              );
            } else {
              return const Padding(padding: EdgeInsets.only(bottom: 8));
            }
          })
        ],
      ),
    );
  }

  Widget buildProductItem(ReceiptProductEntity product) {
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
        ListView.separated(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              final detail = product.itemDetailList![index];
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("${detail.quantity} x "),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          FormatUtil.formatSize(detail.size ?? ''),
                          style: AppStyle.normalTextStyleDark,
                        ),
                        if (detail.toppings != null &&
                            detail.toppings!.isNotEmpty)
                          Text(detail.toppingOrderString,
                              style: AppStyle.normalTextStyleDark),
                        if (detail.note != null && detail.note!.isNotEmpty)
                          Row(children: [
                            Icon(
                              Icons.sticky_note_2_outlined,
                              color: AppColor.primaryColor,
                              size: 18,
                            ),
                            Expanded(
                              child: Text(
                                detail.note!,
                                style: AppStyle.normalTextStyleDark,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            )
                          ])
                      ],
                    ),
                  ),
                  if (detail.productDiscount == null &&
                      detail.productDiscount != 0.0)
                    Text(FormatUtil.formatMoney(detail.total),
                        style: AppStyle.normalTextStyleDark),
                  if (detail.productDiscount == null &&
                      detail.productDiscount != 0.0)
                    Column(
                      children: [
                        Text(FormatUtil.formatMoney(detail.totalAfterDiscount)),
                        Text(FormatUtil.formatMoney(detail.total),
                            style: AppStyle.normalTextStyleDark.copyWith(
                                color: AppColor.nonactiveColor,
                                decoration: TextDecoration.lineThrough)),
                      ],
                    ),
                  buildProductBoughtPrice(detail)
                ],
              );
            },
            separatorBuilder: (context, index) {
              return SizedBox(height: 4);
            },
            itemCount: product.itemDetailList!.length)
      ],
    );
  }

  Widget buildProductBoughtPrice(ReceiptProductDetailEntity detail) {
    if (detail.productDiscount != null && detail.productDiscount != 0.0) {
      return Column(
        children: [
          Text(FormatUtil.formatMoney(detail.totalAfterDiscount)),
          Text(FormatUtil.formatMoney(detail.total),
              style: AppStyle.normalTextStyleDark.copyWith(
                  color: AppColor.nonactiveColor,
                  decoration: TextDecoration.lineThrough)),
        ],
      );
    }
    return Text(FormatUtil.formatMoney(detail.total),
        style: AppStyle.normalTextStyleDark);
  }
}
