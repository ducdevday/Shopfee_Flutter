part of cart;

class ProductGiftItem extends StatelessWidget {
  final int index;

  const ProductGiftItem({
    Key? key,
    required this.index,
  }) : super(key: key);

  void handleClickSlidable(BuildContext context) {
    final controller = Slidable.of(context)!;
    final isClosed = controller.actionPaneType.value ==
        ActionPaneType.none; // you can use this to check if its closed
    if (isClosed) {
      // use this to open it
      controller.openEndActionPane();
    } else {
      // if you want to close the ActionPane
      controller.close();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        if (state is CartLoaded) {
          return Padding(
            padding: EdgeInsets.only(top: 4, bottom: 4, right: 8),
            child: Row(
              children: [
                Visibility(
                  visible: false,
                  maintainSize: true,
                  maintainAnimation: true,
                  maintainState: true,
                  child: Center(
                    child: IconButton(
                      onPressed: () {
                      },
                      icon: SvgPicture.asset(
                        AppPath.icEdit,
                        color: AppColor.primaryColor,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 4,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          "${state.cart.productCouponResult!.reward!.productRewardList![index].quantity}x ${state.cart.productCouponResult!.reward!.productRewardList![index].name!}",
                          style: AppStyle.mediumTitleStyleDark
                              .copyWith(color: AppColor.headingColor)
                              .copyWith(fontWeight: FontWeight.w500)),
                      // if (state.cart.productCouponResult!.reward!
                      //             .productRewardList![index].size !=
                      //         null &&
                      //     state.cart.productCouponResult!.reward!
                      //             .productRewardList![index].size !=
                      //         "")
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 6,
                          ),
                          Text(
                            FormatUtil.formatSize("SMALL"),
                            style: AppStyle.normalTextStyleDark,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        } else {
          return SizedBox();
        }
      },
    );
  }
}
