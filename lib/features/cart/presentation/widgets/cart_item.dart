part of cart;

class CartItem extends StatelessWidget {
  final int index;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const CartItem(
      {Key? key,
      required this.index,
      required this.onEdit,
      required this.onDelete})
      : super(key: key);

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
          return Slidable(
            endActionPane: ActionPane(
              extentRatio: 0.55,
              motion: ScrollMotion(),
              children: [
                SlidableAction(
                  // An action can be bigger than the others.
                  onPressed: (context) {
                    onEdit();
                  },
                  backgroundColor: Colors.grey,
                  foregroundColor: Colors.white,
                  icon: Icons.edit_rounded,
                  label: 'Edit',
                ),
                SlidableAction(
                  onPressed: (context) {
                    onDelete();
                  },
                  backgroundColor: AppColor.error,
                  foregroundColor: Colors.white,
                  icon: Icons.delete_rounded,
                  label: 'Delete',
                ),
              ],
            ),
            child: Builder(builder: (context) {
              return GestureDetector(
                onTap: () {
                  handleClickSlidable(context);
                },
                child: Padding(
                  padding: EdgeInsets.only(top: 4, bottom: 4, right: 8),
                  child: Row(
                    children: [
                      Center(
                        child: IconButton(
                          onPressed: () {
                            handleClickSlidable(context);
                          },
                          icon: SvgPicture.asset(
                            AppPath.icEdit,
                            color: AppColor.primaryColor,
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
                                "${state.cart.orders[index].quantity}x ${state.cart.orders[index].product.name!}",
                                style: AppStyle.mediumTitleStyleDark
                                    .copyWith(color: AppColor.headingColor)
                                    .copyWith(fontWeight: FontWeight.w500)),
                            SizedBox(
                              height: 6,
                            ),
                            Text(
                              FormatUtil.formatSize(
                                  state.cart.orders[index].size!.size),
                              style: AppStyle.normalTextStyleDark,
                            ),
                            state.cart.orders[index].toppings.isNotEmpty
                                ? Text(
                                    state.cart.orders[index].toppingOrderString,
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
                            Text(
                                FormatUtil.formatMoney(
                                    state.cart.orders[index].total),
                                style: AppStyle.mediumTitleStyleDark
                                    .copyWith(color: AppColor.headingColor)),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );
            }),
          );
        } else {
          return SizedBox();
        }
      },
    );
  }
}
