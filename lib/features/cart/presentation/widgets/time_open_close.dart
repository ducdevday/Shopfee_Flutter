part of cart;

class TimeOpenClose extends StatelessWidget {
  const TimeOpenClose({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Time order",
          style: AppStyle.mediumTitleStyleDark
              .copyWith(color: AppColor.headingColor),
        ),
        const SizedBox(
          height: 4,
        ),
        BlocBuilder<CartBloc, CartState>(
          builder: (context, state) {
            if (state is CartLoaded) {
              if (state.cart.store != null &&
                  state.cart.orderType == OrderType.ONSITE) {
                return Column(
                  children: [
                    Text(
                      "*We are open from ${state.cart.store?.openTime} AM - ${state.cart.store?.closeTime} PM",
                      style: AppStyle.normalTextStyleDark,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                  ],
                );
              }
            }
            return const SizedBox();
          },
        ),
      ],
    );
  }
}
