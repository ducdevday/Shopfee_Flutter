part of cart;

class CartItem extends StatelessWidget {
  final int index;
  final VoidCallback callback;

  const CartItem({Key? key, required this.index, required this.callback}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        if (state is CartLoaded) {
          return IntrinsicHeight(
            child: Row(
              children: [
                Center(
                  child: TextButton.icon(
                    onPressed: () {
                      callback();
                    },
                    icon: SvgPicture.asset(
                      AppPath.icEdit,
                      color: AppColor.primaryColor,
                    ),
                    label: Text(
                      "Edit",
                      style: AppStyle.mediumTitleStyleDark
                          .copyWith(color: AppColor.primaryColor, fontSize: 12),
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
                      Text("${state.cart.orders[index].quantity}x ${state.cart.orders[index].product.name!}",
                          style: AppStyle.mediumTitleStyleDark
                              .copyWith(color: AppColor.headingColor).copyWith(fontWeight: FontWeight.w500)),
                      SizedBox(
                        height: 6,
                      ),
                      Text(
                        FormatUtil.formatSize(state.cart.orders[index].size!.size),
                        style: AppStyle.normalTextStyleDark,
                      ),
                      state.cart.orders[index].toppings.isNotEmpty
                          ? Text(state.cart.orders[index].toppingOrderString,
                          style: AppStyle.normalTextStyleDark)
                          : SizedBox(),
                      state.cart.orders[index].note.isNotEmpty
                          ? Row(
                        children: [
                          Icon(
                            Icons.sticky_note_2_outlined,
                            color: AppColor.primaryColor,
                            size: 18,
                          ),
                          Expanded(
                            child: Text(
                              state.cart.orders[index].note,
                              style: AppStyle.normalTextStyleDark,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          )
                        ],
                      )
                          : SizedBox()
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(FormatUtil.formatMoney(state.cart.orders[index].total),
                          style: AppStyle.mediumTitleStyleDark
                              .copyWith(color: AppColor.headingColor)),
                    ],
                  ),
                )
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