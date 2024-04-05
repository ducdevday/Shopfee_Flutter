part of cart;

class ProductGiftList extends StatefulWidget {
  const ProductGiftList({
    super.key,
  });

  @override
  State<ProductGiftList> createState() => _ProductGiftListState();
}

class _ProductGiftListState extends State<ProductGiftList> {
  late int defaultLength = 3;
  late int maxLength = 3;
  late int productListLength;
  late String defaultText = "Show more";
  late Icon defaultIcon = Icon(Icons.keyboard_arrow_down_rounded);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        if (state is CartLoaded) {
          if(state.cart.haveProductGiftList()){
            productListLength = state.cart.productCouponResult!.reward!.productRewardList!.length;
            return Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(AppDimen.screenPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Gift-Giving Product List",
                        style: AppStyle.mediumTitleStyleDark.copyWith(
                            color: AppColor.headingColor,
                            fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      ListView.separated(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: productListLength < defaultLength
                            ? productListLength
                            : maxLength,
                        itemBuilder: (context, index) {
                          return ProductGiftItem(index: index);
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return Divider(
                            height: 1,
                          );
                        },
                      ),
                    ],
                  ),
                ),
                Builder(builder: (context) {
                  if (defaultLength < productListLength) {
                    return Column(
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Divider(
                          height: 1,
                        ),
                        Directionality(
                          textDirection: TextDirection.rtl,
                          child: TextButton.icon(
                            onPressed: () {
                              if (maxLength == 3) {
                                setState(() {
                                  maxLength = productListLength;
                                  defaultText = "Show less";
                                  defaultIcon =
                                      Icon(Icons.keyboard_arrow_up_rounded);
                                });
                              } else {
                                setState(() {
                                  maxLength = 3;
                                  defaultText = "Show more";
                                  defaultIcon =
                                      Icon(Icons.keyboard_arrow_down_rounded);
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
                    return SizedBox();
                  }
                }),
                Container(
                  height: 4,
                  color: AppColor.scaffoldColorBackground,
                ),
              ],
            );

          }
        }
        return SizedBox();
      },
    );
  }

  Future<void> buildShowEditOrderBottomSheet(
      BuildContext context, OrderEntity order, int index) {
    return showModalBottomSheet<void>(
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20)),
        ),
        context: context,
        builder: (BuildContext context) {
          return EditOrderBottomSheet(order: order, index: index);
        });
  }
}
