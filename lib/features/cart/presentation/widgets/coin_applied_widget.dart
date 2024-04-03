part of cart;

class CoinAppliedWidget extends StatelessWidget {
  const CoinAppliedWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Coin",
          style: AppStyle.mediumTitleStyleDark.copyWith(
              color: AppColor.headingColor, fontWeight: FontWeight.w500),
        ),
        SizedBox(
          height: 4,
        ),
        BlocBuilder<UserBloc, UserState>(
          builder: (context, state) {
            if (state is UserLoadSuccess) {
              final user = state.user;

              if (state.user.coin! == 0) {
                return Row(
                  children: [
                    Image.asset(
                      AppPath.icCoin,
                      width: AppDimen.smallSize,
                      height: AppDimen.smallSize,
                    ),
                    SizedBox(
                      width: 4,
                    ),
                    Expanded(
                      child: Text("Can't use coins",
                          style: AppStyle.normalTextStylePrimary),
                    ),
                    SizedBox(
                      height: 30,
                      child: FittedBox(
                        fit: BoxFit.contain,
                        child: CupertinoSwitch(
                            value: false, onChanged: (bool value) {}),
                      ),
                    )
                  ],
                );
              }
              return BlocConsumer<CartBloc, CartState>(
                listener: (context, state) {
                  if (state is CartLoaded) {
                    final cart = state.cart;
                    final validCoin = cart.getValidCoin(user.coin!);
                    if(cart.coin!= null && cart.coin != cart.getValidCoin(user.coin!)){
                      context
                          .read<CartBloc>()
                          .add(CartApplyCoin(coin: validCoin));
                    }
                  }
                },
                builder: (context, state) {
                  if (state is CartLoaded) {
                    final cart = state.cart;
                    final validCoin = cart.getValidCoin(user.coin!);
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(
                          AppPath.icCoin,
                          width: AppDimen.smallSize,
                          height: AppDimen.smallSize,
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Use ${FormatUtil.formatCoin(validCoin)}",
                                  style: AppStyle.normalTextStylePrimary),
                              Text(
                                  "(Current coins: ${FormatUtil.formatCoin(user.coin)})",
                                  style: AppStyle.normalTextStylePrimary),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 30,
                          child: FittedBox(
                            fit: BoxFit.contain,
                            child: CupertinoSwitch(
                                value: cart.coin != null,
                                onChanged: (bool value) {
                                  if (value) {
                                    context
                                        .read<CartBloc>()
                                        .add(CartApplyCoin(coin: validCoin));
                                  } else {
                                    context
                                        .read<CartBloc>()
                                        .add(CartRemoveCoin());
                                  }
                                }),
                          ),
                        )
                      ],
                    );
                  }
                  return SizedBox();
                },
              );
            }
            return SizedBox();
          },
        ),
      ],
    );
  }
}
