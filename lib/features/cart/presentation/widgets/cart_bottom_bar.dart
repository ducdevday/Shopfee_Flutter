part of cart;

class CartBottomBar extends StatefulWidget {
  const CartBottomBar({Key? key}) : super(key: key);

  @override
  State<CartBottomBar> createState() => _CartBottomBarState();
}

class _CartBottomBarState extends State<CartBottomBar> {
  late UserState userState;
  late UserEntity user;

  @override
  void initState() {
    super.initState();
    userState = context.read<UserBloc>().state;
    if (userState is UserLoadSuccess) {
      user = (userState as UserLoadSuccess).user;
    }
  }

  void showEditPhoneDialog() {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) => MyPhoneInputDialog(
        title: "Update Your Phone Number",
        content: "Before order, you must update your phone number",
        cancelText: "Cancel",
        confirmText: "Confirm",
        callbackOK: (String phoneNumber) {
          Navigator.of(dialogContext).pop();
          context.read<UserBloc>().add(UserUpdateInformation(
            user: user.copyWith(phoneNumber: phoneNumber),
          ));
        },
        callbackCancel: () {
          Navigator.of(dialogContext).pop();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        if (state is CartLoaded) {
          final cart = state.cart;
          final totalPrice = cart.getTotalCartPrice();
          final isOrderValid = cart.isOrderValid();
          final isShippingOrder = cart.orderType == OrderType.SHIPPING;
          final hasPhoneNumber = user.phoneNumber != null;

          return BottomAppBar(
            height: 70,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppDimen.screenPadding,
              ),
              child: ElevatedButton(
                onPressed: isOrderValid
                    ? () {
                  if (userState is UserLoadSuccess) {
                    if (hasPhoneNumber) {
                      context.read<CartBloc>().add(
                        isShippingOrder
                            ? CartCreateShippingOrder()
                            : CartCreateTakeAwayOrder(),
                      );
                    } else {
                      showEditPhoneDialog();
                    }
                  } else {
                    NavigationUtil.pushNamed(
                      LoginPage.route,
                      arguments: CartPage.route,
                    );
                  }
                }
                    : null,
                style: AppStyle.elevatedButtonStylePrimary,
                child: Text("Order (${FormatUtil.formatMoney(totalPrice)})"),
              ),
            ),
          );
        }
        return SizedBox();
      },
    );
  }
}
