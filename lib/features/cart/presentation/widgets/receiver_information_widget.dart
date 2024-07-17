part of cart;

class ReceiverInformationWidget extends StatelessWidget {
  const ReceiverInformationWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        if (state is CartLoaded) {
          if (state.cart.orderType == OrderType.ONSITE) {
            if (state.cart.receiverOnsite != null) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: AppDimen.spacing,),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.account_circle_outlined, size: AppDimen.smallSize,color: AppColor.primaryColor,),
                                SizedBox(width: AppDimen.smallSpacing,),
                                Text(
                                  "${state.cart.receiverOnsite?.recipientName}",
                                  style: AppStyle.mediumTextStyleDark
                                      .copyWith(color: AppColor.headingColor),
                                ),
                                Text(
                                  "  |  ",
                                  style: AppStyle.normalTextStyleDark,
                                ),
                                Expanded(
                                  child: Text(
                                    "${state.cart.receiverOnsite?.phoneNumber ?? ""}",
                                    style: AppStyle.normalTextStyleDark,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  if (state.cart.receiverOnsite?.phoneNumber == null)
                    Text(
                      R.needUpdatePhoneNumber.tr(),
                      style: AppStyle.normalTextStylePrimary
                          .copyWith(color: AppColor.error),
                    ),
                  InkWell(
                    onTap: () {
                      buildReceiverPaymentBottomSheet(context);
                    },
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            R.updateReceiver.tr(),
                            style: AppStyle.normalTextStylePrimary,
                          ),
                        ),
                        const SizedBox(
                          width: 40,
                        ),
                        const Icon(Icons.keyboard_arrow_right_rounded),
                      ],
                    ),
                  )
                ],
              );
            }
          }
        }
        return const SizedBox();
      },
    );
  }

  Future<void> buildReceiverPaymentBottomSheet(BuildContext context) {
    return showModalBottomSheet<void>(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20)),
      ),
      context: context,
      builder: (BuildContext context) {
        return const ReceiverInformationBottomSheet();
      },
    );
  }
}
