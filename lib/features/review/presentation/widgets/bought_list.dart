part of review;

class BoughtList extends StatefulWidget {
  final List<ReceiptProductEntity>? itemList;

  const BoughtList({
    super.key,
    this.itemList,
  });

  @override
  State<BoughtList> createState() => _BoughtListState();
}

class _BoughtListState extends State<BoughtList> {
  late int defaultLength = 3;
  late int maxLength = 3;
  late int boughtListLength;
  late String defaultText = "Show more";
  late Icon defaultIcon = const Icon(Icons.keyboard_arrow_down_rounded);

  @override
  void initState() {
    super.initState();
    boughtListLength = widget.itemList!.length;
  }

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
              ListView.separated(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: boughtListLength < defaultLength
                    ? boughtListLength
                    : maxLength,
                itemBuilder: (context, index) {
                  return buildProductItem(widget.itemList![index]);
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const Divider(
                    height: 10,
                  );
                },
              )
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
                          defaultIcon =
                              const Icon(Icons.keyboard_arrow_up_rounded);
                        });
                      } else {
                        setState(() {
                          maxLength = 3;
                          defaultText = "Show more";
                          defaultIcon =
                              const Icon(Icons.keyboard_arrow_down_rounded);
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

  Widget buildProductItem(ReceiptProductEntity product) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(AppDimen.spacing),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: const BoxDecoration(
                  color: Color(0xffF0F0F0),
                ),
                child: Row(
                  children: [
                    Image.network(
                      "https://firebasestorage.googleapis.com/v0/b/shopfee-12b03.appspot.com/o/product%2FAmericano.png?alt=media&token=f3a409c3-4da7-4a06-bc49-17c675fe9aa8",
                      width: AppDimen.smallImageSize,
                      height: AppDimen.smallImageSize,
                    ),
                    Text("${product.name}",
                        style: AppStyle.mediumTextStyleDark
                            .copyWith(color: AppColor.headingColor)
                            .copyWith(fontWeight: FontWeight.w500)),
                  ],
                ),
              ),
              const SizedBox(
                height: 6,
              ),
              Text(
                "${FormatUtil.formatTime(DateTime.now())} - ${FormatUtil.formatDate(DateTime.now())}",
                style: AppStyle.normalTextStyleDark,
              ),
              const SizedBox(
                height: 4,
              ),
              Row(
                children: [
                  Icon(
                    Icons.star_rounded,
                    color: Colors.amber,
                    size: 20,
                  ),
                  Icon(
                    Icons.star_rounded,
                    color: Colors.amber,
                    size: 20,
                  ),
                  Icon(
                    Icons.star_rounded,
                    color: Colors.amber,
                    size: 20,
                  ),
                  Icon(
                    Icons.star_rounded,
                    color: Colors.amber,
                    size: 20,
                  ),
                  Icon(
                    Icons.star_border_rounded,
                    color: Colors.amber,
                    size: 20,
                  )
                ],
              ),
              const SizedBox(
                height: 4,
              ),
              Row(
                children: [
                  Icon(
                    Icons.rate_review_outlined,
                    color: AppColor.dividerColor,
                    size: 20,
                  ),
                  SizedBox(
                    width: AppDimen.spacing,
                  ),
                  Text(
                    "OK",
                    style: AppStyle.normalTextStyleDark,
                  ),
                ],
              )
            ],
          ),
        ),
        SizedBox(
          height: AppDimen.spacing,
        ),
        Container(
          padding: EdgeInsets.all(AppDimen.spacing),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: const BoxDecoration(
                  color: Color(0xffF0F0F0),
                ),
                child: Row(
                  children: [
                    Image.network(
                      "https://firebasestorage.googleapis.com/v0/b/shopfee-12b03.appspot.com/o/product%2Fce99c8d6-1ebf-488a-a80f-dd4c12ee0dee.png?alt=media&token=b7a6ed2f-42a3-4937-b75d-7eb4fbdb7628",
                      width: AppDimen.smallImageSize,
                      height: AppDimen.smallImageSize,
                    ),
                    Text("${product.name}",
                        style: AppStyle.mediumTextStyleDark
                            .copyWith(color: AppColor.headingColor)
                            .copyWith(fontWeight: FontWeight.w500)),
                  ],
                ),
              ),
              const SizedBox(
                height: 6,
              ),
              Directionality(
                textDirection: TextDirection.rtl,
                child: TextButton.icon(
                    onPressed: () {},
                    icon: Icon(Icons.keyboard_arrow_right_rounded),
                    label: Text(
                      "Leave a review",
                      style: AppStyle.normalTextStylePrimary
                          .copyWith(fontWeight: FontWeight.w500),
                    )),
              )
            ],
          ),
        ),
      ],
    );
  }
}
