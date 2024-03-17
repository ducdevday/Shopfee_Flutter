part of cart;

class PaymentSummary extends StatelessWidget {
  const PaymentSummary({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        if (state is CartLoaded) {
          final cart = state.cart;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Payment Summary",
                  style: AppStyle.mediumTitleStyleDark
                      .copyWith(color: AppColor.headingColor)),
              const SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Item Price",
                    style: AppStyle.normalTextStyleDark
                        .copyWith(fontWeight: FontWeight.w400),
                  ),
                  Text(
                    FormatUtil.formatMoney(cart.totalItemPrice),
                    style: AppStyle.normalTextStyleDark
                        .copyWith(fontWeight: FontWeight.w400),
                  )
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Shipping fee",
                    style: AppStyle.normalTextStyleDark
                        .copyWith(fontWeight: FontWeight.w400),
                  ),
                  Text(
                    FormatUtil.formatMoney(cart.getCalculatedShippingFee()),
                    style: AppStyle.normalTextStyleDark
                        .copyWith(fontWeight: FontWeight.w400),
                  )
                ],
              ),
              // SizedBox(
              //   height: 8,
              // ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     Text(
              //       "Voucher",
              //       style: AppStyle.normalTextStyleDark
              //           .copyWith(fontWeight: FontWeight.w400),
              //     ),
              //     Text(
              //       "-30,000đ",
              //       style: AppStyle.normalTextStyleDark
              //           .copyWith(fontWeight: FontWeight.w400),
              //     )
              //   ],
              // ),
              if (cart.coin != null)
                Column(
                  children: [
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Applied Coin",
                          style: AppStyle.normalTextStyleDark
                              .copyWith(fontWeight: FontWeight.w400),
                        ),
                        Text(
                          "- ${FormatUtil.formatMoney(cart.coin)}",
                          style: AppStyle.normalTextStyleDark
                              .copyWith(fontWeight: FontWeight.w400),
                        )
                      ],
                    ),
                  ],
                ),
              const SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Total",
                    style: AppStyle.mediumTitleStyleDark,
                  ),
                  Text(
                    FormatUtil.formatMoney(cart.getTotalCartPrice()),
                    style: AppStyle.mediumTitleStyleDark,
                  )
                ],
              )
            ],
          );
        }
        return SizedBox();
      },
    );
  }
}
