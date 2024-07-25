part of cart;

class CartBottomBar extends StatelessWidget {
  const CartBottomBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        if (state is CartLoaded) {
          final cart = state.cart;
          final totalPrice = cart.getCartTotalPrice();
          final isOrderValid = cart.isOrderValid();
          final isShippingOrder = cart.orderType == OrderType.SHIPPING;
          final isConflictBranchShipping =
              cart.cartInvalidBranchList.isNotEmpty == true;
          return BottomAppBar(
            height: 70,
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppDimen.screenPadding,
              ),
              child: BlocBuilder<UserBloc, UserState>(
                builder: (context, userState) {
                  if (userState is UserLoadSuccess) {
                    return Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: isOrderValid
                                ? () {
                                    context.read<CartBloc>().add(isShippingOrder
                                        ? CartCreateShippingOrder()
                                        : CartCreateTakeAwayOrder());
                                  }
                                : null,
                            style: AppStyle.elevatedButtonStylePrimary,
                            child: Text(
                                "${R.order.tr()} (${FormatUtil.formatMoney(totalPrice)})", textAlign: TextAlign.center),
                          ),
                        ),
                        if (isConflictBranchShipping)
                          SizedBox(width: AppDimen.spacing,),
                        if (isConflictBranchShipping)
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                buildShowBranchShippingBottomSheet(context);
                              },
                              style: AppStyle.elevatedButtonStyleSecondary,
                              child: Text(R.recheck.tr(),textAlign: TextAlign.center,),
                            ),
                          )
                      ],
                    );
                  } else {
                    return ElevatedButton(
                      onPressed: () {
                        NavigationUtil.pushNamed(LoginPage.route,
                            arguments: DefaultPage.route);
                      },
                      child: Text(R.registerOrLoginToOrder.tr()),
                      style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              vertical: 12, horizontal: 24),
                          disabledBackgroundColor: const Color(0xffCACACA),
                          disabledForegroundColor: AppColor.lightColor,
                          textStyle: AppStyle.mediumTextStyleDark,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          )),
                    );
                  }
                },
              ),
            ),
          );
        }
        return SizedBox();
      },
    );
  }
}
