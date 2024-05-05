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

          return BottomAppBar(
            height: 70,
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppDimen.screenPadding,
              ),
              child: BlocBuilder<UserBloc, UserState>(
                builder: (context, userState) {
                  if(userState is UserLoadSuccess){
                    return ElevatedButton(
                      onPressed: isOrderValid
                          ? () {
                        context.read<CartBloc>().add(isShippingOrder
                            ? CartCreateShippingOrder()
                            : CartCreateTakeAwayOrder());
                      }
                          : null,
                      style: AppStyle.elevatedButtonStylePrimary,
                      child: Text(
                          "Order (${FormatUtil.formatMoney(totalPrice)})"),
                    );
                  }else{
                    return ElevatedButton(
                      onPressed: () {
                        NavigationUtil.pushNamed(LoginPage.route,
                            arguments: DefaultPage.route);
                      },
                      child: const Text("Register / Log In To Order"),
                      style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              vertical: 12, horizontal: 24),
                          disabledBackgroundColor:
                          const Color(0xffCACACA),
                          disabledForegroundColor:
                          AppColor.lightColor,
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
