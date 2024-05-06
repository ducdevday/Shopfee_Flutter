part of cart;

class PaymentMethod extends StatelessWidget {
  const PaymentMethod({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        if (state is CartLoaded) {
          return GestureDetector(
            onTap: () {
              buildShowPaymentBottomSheet(context);
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Payment Method",
                  style: AppStyle.mediumTitleStyleDark.copyWith(
                      color: AppColor.headingColor,
                      fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 4,
                ),
                Row(
                  children: [
                    Image.asset(
                      state.cart.paymentType!.getIconPath(),
                      width: 24,
                      height: 24,
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    Expanded(
                        child: Text(state.cart.paymentType!.getFormattedName(),
                            style: AppStyle.normalTextStyleDark)),
                    const Icon(Icons.keyboard_arrow_right_rounded)
                  ],
                ),
                if (!state.cart.isVnPayOrZaloPayValid())
                  Padding(
                    padding: const EdgeInsets.only(top: AppDimen.smallSpacing),
                    child: Text(
                      "Online payment is only applicable when orders are over 10,000đ",
                      style: AppStyle.normalTextStyleDark
                          .copyWith(color: AppColor.error),
                    ),
                  )
              ],
            ),
          );
        }
        return SizedBox();
      },
    );
  }
}

Future<void> buildShowPaymentBottomSheet(BuildContext context) {
  return showModalBottomSheet<void>(
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20), topRight: Radius.circular(20)),
    ),
    context: context,
    builder: (BuildContext context) {
      return const PaymentBottomSheet();
    },
  );
}
