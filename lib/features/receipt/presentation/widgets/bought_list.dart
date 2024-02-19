part of receipt;

class ItemList extends StatefulWidget {
  const ItemList({
    super.key,
  });

  @override
  State<ItemList> createState() => _ItemListState();
}

class _ItemListState extends State<ItemList> {
  late int defaultLength = 3;
  late int maxLength = 3;
  late int boughtListLength;
  late String defaultText = "Show more";
  late Icon defaultIcon = const Icon(Icons.keyboard_arrow_down_rounded);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8.0, top: 8.0, right: 8.0),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Item list",
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
                    boughtListLength = state.receipt.products!.length;
                    return ListView.separated(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: boughtListLength < defaultLength
                          ? boughtListLength
                          : maxLength,
                      itemBuilder: (context, index) {
                        return buildProductItem(state, index);
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
                Directionality(
                  textDirection: TextDirection.rtl,
                  child: TextButton.icon(
                    onPressed: () {
                      if (maxLength == 3) {
                        setState(() {
                          maxLength = boughtListLength;
                          defaultText = "Show less";
                          defaultIcon = const Icon(Icons.keyboard_arrow_up_rounded);
                        });
                      } else {
                        setState(() {
                          maxLength = 3;
                          defaultText = "Show more";
                          defaultIcon = const Icon(Icons.keyboard_arrow_down_rounded);
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
    );
  }

  Widget buildProductItem(ReceiptLoadSuccess state, int index) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                  "${state.receipt.products![index].quantity}x ${state.receipt.products![index].name!}",
                  style: AppStyle.mediumTitleStyleDark
                      .copyWith(color: AppColor.headingColor)
                      .copyWith(fontWeight: FontWeight.w500)),
              const SizedBox(
                height: 6,
              ),
              Text(
                state.receipt.products![index].size!,
                style: AppStyle.normalTextStyleDark,
              ),
              state.receipt.products![index].toppings!.isNotEmpty
                  ? Text(state.receipt.products![index].toppingOrderString,
                      style: AppStyle.normalTextStyleDark)
                  : const SizedBox(),
              state.receipt.products![index].note!.isNotEmpty
                  ? Row(
                      children: [
                        Icon(
                          Icons.sticky_note_2_outlined,
                          color: AppColor.primaryColor,
                          size: 18,
                        ),
                        Expanded(
                          child: Text(
                            state.receipt.products![index].note!,
                            style: AppStyle.normalTextStyleDark,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        )
                      ],
                    )
                  : const SizedBox()
            ],
          ),
        ),
        Align(
          alignment: Alignment.topRight,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(FormatUtil.formatMoney(state.receipt.products![index].total),
                  style: AppStyle.mediumTitleStyleDark
                      .copyWith(color: AppColor.headingColor)),
            ],
          ),
        )
      ],
    );
  }
}
