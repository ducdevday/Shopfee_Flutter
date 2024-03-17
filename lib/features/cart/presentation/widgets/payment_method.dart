part of cart;

class PaymentMethod extends StatelessWidget {
  const PaymentMethod({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        if(state is CartLoaded){
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
                      color: AppColor.headingColor, fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 4,
                ),
                Builder(builder: (context) {
                  if (state.cart.paymentType == PaymentType.CASHING) {
                    return Row(
                      children: [
                        Image.asset(
                          AppPath.icCash,
                          width: 24,
                          height: 24,
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        Expanded(
                            child: Text(
                                "Cash", style: AppStyle.normalTextStyleDark)),
                        const Icon(Icons.keyboard_arrow_right_rounded)
                      ],
                    );
                  } else {
                    return Row(
                      children: [
                        Image.asset(
                          AppPath.icVnPay,
                          width: 24,
                          height: 24,
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        Expanded(
                            child:
                            Text("VNPay", style: AppStyle.normalTextStyleDark)),
                        const Icon(Icons.keyboard_arrow_right_rounded)
                      ],
                    );
                  }
                }),
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