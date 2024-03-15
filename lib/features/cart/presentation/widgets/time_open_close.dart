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
        // Builder(builder: (_) {
        //   // if (!(DateTime.now().hour >= 8 && DateTime.now().hour < 20)) {
        //   //   return Text(
        //   //     "*We are open from 08:00 AM - 20:00 PM",
        //   //     style: AppStyle.normalTextStyleDark.copyWith(color: AppColor.error),
        //   //   );
        //   // } else {
        //   return Text(
        //     "*We are open from 08:00 AM - 20:00 PM",
        //     style: AppStyle.normalTextStyleDark,
        //   );
        //   // }
        // }),
        BlocBuilder<CartBloc, CartState>(
          builder: (context, state) {
            if (state is CartLoaded) {
              if (state.cart.store != null) {
                return Text(
                  "*We are open from ${state.cart.store?.openTime} AM - ${state.cart.store?.closeTime} PM",
                  style: AppStyle.normalTextStyleDark,
                );
              }
            }
            return Text(
              "*We are open from 08:00 AM - 20:00 PM",
              style: AppStyle.normalTextStyleDark,
            );
          },
        ),
        const SizedBox(
          height: 16,
        ),
      ],
    );
  }
}
