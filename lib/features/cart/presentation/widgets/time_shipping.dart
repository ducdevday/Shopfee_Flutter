part of cart;

class TimeShipping extends StatelessWidget {
  const TimeShipping({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        if (state is CartLoaded) {
          if (state.cart.orderType == OrderType.SHIPPING) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "As soon as posible",
                      style: AppStyle.mediumTextStyleDark.copyWith(
                          color: AppColor.headingColor,
                          fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.access_time_filled_rounded,
                          color: AppColor.primaryColor,
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        Text("Now - 10 Minute",
                            style: AppStyle.normalTextStyleDark),
                      ],
                    ),
                  ],
                ),
                // TimeSetter()
              ],
            );
          }
        }
        return SizedBox();
      },
    );
  }
}
