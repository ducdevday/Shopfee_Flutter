part of cart;

class CartPage extends StatefulWidget {
  static const String route = "/cart";

  const CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  void initState() {
    super.initState();
    context.read<CartBloc>().add(CartInitAddress());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CartBloc, CartState>(
      listener: (context, state) {
        if (state is CartFinished) {
          if (state.orderResult.paymentUrl == null) {
            NavigationUtil.pushNamedAndRemoveUntil(ReceiptPage.route,
                    arguments: state.orderResult.orderId)
                .then((value) => NavigationUtil.pushNamed(DefaultPage.route));
          } else {
            NavigationUtil.pushNamedAndRemoveUntil(VnPayPage.route,
                    arguments: state.orderResult)
                .then((value) => NavigationUtil.pushNamed(DefaultPage.route));
          }
        }
      },
      builder: (context, state) {
        if (state is CartLoaded) {
          if (state.cart.orders.isEmpty) {
            return buildEmptyCart(context);
          } else {
            return Scaffold(
              appBar: AppBar(
                title: const Text("Cart"),
                centerTitle: true,
                bottom: const PreferredSize(
                  preferredSize: Size.fromHeight(1),
                  child: Divider(height: 1),
                ),
                actions: [
                  IconButton(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext dialogContext) =>
                                MyConfirmDialog(
                                  title: "Confirm",
                                  content:
                                      "Do you want to delete all products from your cart",
                                  callbackOK: () {
                                    context
                                        .read<CartBloc>()
                                        .add(CartDeleteInformation());
                                    Navigator.pop(dialogContext);
                                  },
                                  callbackCancel: () {
                                    Navigator.pop(dialogContext);
                                  },
                                  confirmText: "Delete",
                                ));
                      },
                      icon: Icon(
                        Icons.delete_outline_rounded,
                        color: AppColor.primaryColor,
                      ))
                ],
              ),
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      height: 4,
                      color: const Color(0xffEFEBE9),
                    ),
                    const ProductList(),
                    Container(
                      height: 4,
                      color: const Color(0xffEFEBE9),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: AppDimen.screenPadding),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              buildOrderTypeText(state),
                              TextButton(
                                child: Text(
                                  "Change",
                                  style: AppStyle.normalTextStylePrimary,
                                ),
                                onPressed: () {
                                  buildShowDeliveryBottomSheet(context);
                                },
                              )
                            ],
                          ),
                          const AddressShippingWidget(),
                          const StoreWidget(),
                          const Divider(
                            height: 20,
                          ),
                          const TimeOpenClose(),
                          const TimeShipping(),
                          const TimeSetter(),
                          const Divider(
                            height: 20,
                          ),
                          TextFormField(
                            onChanged: (value) => {
                              context
                                  .read<CartBloc>()
                                  .add(CartAddNote(note: value))
                            },
                            style: const TextStyle(fontSize: 14),
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.all(8),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Color(0xffCCCCCC)),
                                  borderRadius: BorderRadius.circular(8)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Color(0xffCCCCCC)),
                                  borderRadius: BorderRadius.circular(8)),
                              hintText: "Additional note for shop...",
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 4,
                      color: const Color(0xffEFEBE9),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 10, horizontal: AppDimen.screenPadding),
                      child: PaymentMethod(),
                    ),
                    Container(
                      height: 4,
                      color: const Color(0xffEFEBE9),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 10, horizontal: AppDimen.screenPadding),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CouponAppliedWidget(),
                          Divider(
                            height: 20,
                          ),
                          CoinAppliedWidget()
                        ],
                      ),
                    ),
                    Container(
                      height: 4,
                      color: const Color(0xffEFEBE9),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(AppDimen.screenPadding),
                      child: PaymentSummary(),
                    )
                  ],
                ),
              ),
              bottomNavigationBar: const CartBottomBar(),
            );
          }
        } else {
          return const SizedBox();
        }
      },
    );
  }

  Text buildOrderTypeText(CartLoaded state) {
    if (state.cart.orderType == OrderType.SHIPPING) {
      return Text("Home Delivery",
          style: AppStyle.mediumTitleStyleDark
              .copyWith(color: AppColor.headingColor));
    } else {
      return Text("Take Away",
          style: AppStyle.mediumTitleStyleDark
              .copyWith(color: AppColor.headingColor));
    }
  }

  Scaffold buildEmptyCart(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border:
                          Border.all(width: 1, color: AppColor.primaryColor)),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: SvgPicture.asset(
                      AppPath.icShoppingBag,
                      width: 120,
                      height: 120,
                      color: AppColor.primaryColor,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "Your cart is empty",
                  style: AppStyle.largeTitleStyleDark,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "You didn't add any product into your cart",
                  style: AppStyle.mediumTextStyleDark,
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.all(AppDimen.screenPadding),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("Order now"),
                style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 24),
                    disabledBackgroundColor: const Color(0xffCACACA),
                    disabledForegroundColor: AppColor.lightColor,
                    textStyle: AppStyle.mediumTextStyleDark,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    )),
              ),
            ),
          )
        ],
      ),
    );
  }
}

Future<void> buildShowDeliveryBottomSheet(BuildContext context) {
  return showModalBottomSheet<void>(
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20), topRight: Radius.circular(20)),
    ),
    context: context,
    builder: (BuildContext context) {
      return const DeliveryBottomSheet();
    },
  );
}
