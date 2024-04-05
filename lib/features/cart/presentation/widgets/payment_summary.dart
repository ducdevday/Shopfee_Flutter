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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      "Item Price",
                      style: AppStyle.normalTextStyleDark
                          .copyWith(fontWeight: FontWeight.w400),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      FormatUtil.formatMoney(cart.totalItemPrice),
                      style: AppStyle.normalTextStyleDark
                          .copyWith(fontWeight: FontWeight.w400),
                      textAlign: TextAlign.end,
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      "Shipping fee",
                      style: AppStyle.normalTextStyleDark
                          .copyWith(fontWeight: FontWeight.w400),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      FormatUtil.formatMoney(cart.getCalculatedShippingFee()),
                      style: AppStyle.normalTextStyleDark
                          .copyWith(fontWeight: FontWeight.w400),
                      textAlign: TextAlign.end,
                    ),
                  )
                ],
              ),
              if (cart.coin != null)
                Column(
                  children: [
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            "Applied Coin",
                            style: AppStyle.normalTextStyleDark
                                .copyWith(fontWeight: FontWeight.w400),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            "- ${FormatUtil.formatMoney(cart.coin)}",
                            style: AppStyle.normalTextStyleDark
                                .copyWith(fontWeight: FontWeight.w400, color: AppColor.rating),
                            textAlign: TextAlign.end,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              if (cart.isAppliedCoupon())
                Column(
                  children: [
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            "Applied Coupon",
                            style: AppStyle.normalTextStyleDark
                                .copyWith(fontWeight: FontWeight.w400),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            "- ${FormatUtil.formatMoney(cart.getTotalCouponValue())}",
                            style: AppStyle.normalTextStylePrimary
                                .copyWith(fontWeight: FontWeight.w400),
                            textAlign: TextAlign.end,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              const SizedBox(
                height: 8,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      "Total",
                      style: AppStyle.mediumTitleStyleDark,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      FormatUtil.formatMoney(cart.getCartTotalPrice()),
                      style: AppStyle.mediumTitleStyleDark,
                      textAlign: TextAlign.end,
                    ),
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
