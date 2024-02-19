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
                              Text("Home Delivery",
                                  style: AppStyle.mediumTitleStyleDark
                                      .copyWith(color: AppColor.headingColor)),
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
                          Builder(builder: (context) {
                            if (state.cart.address != null) {
                              return buildAddressDetail(state, context);
                            } else {
                              return AddressEmptyWidget();
                            }
                          }),
                          const Divider(
                            height: 20,
                          ),
                          const TimeOrder(),
                          const Divider(
                            height: 20,
                          ),
                          buildPaymentMethod(state, context),
                          const Divider(
                            height: 20,
                          ),
                          TextFormField(
                            onChanged: (value) => {
                              context.read<CartBloc>().add(CartAddNote(value))
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

                          // Divider(
                          //   height: 20,
                          // ),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //   children: [
                          //     Column(
                          //       crossAxisAlignment: CrossAxisAlignment.start,
                          //       children: [
                          //         Text(
                          //           "Voucher",
                          //           style: AppStyle.mediumTitleStyleDark
                          //               .copyWith(
                          //                   color: AppColor.headingColor,
                          //                   fontWeight: FontWeight.w500),
                          //         ),
                          //         SizedBox(
                          //           height: 4,
                          //         ),
                          //         Row(
                          //           children: [
                          //             Icon(
                          //               Icons.discount,
                          //               color: AppColor.primaryColor,
                          //             ),
                          //             SizedBox(
                          //               width: 4,
                          //             ),
                          //             Text("no voucher added",
                          //                 style: AppStyle.normalTextStyleDark),
                          //           ],
                          //         ),
                          //       ],
                          //     ),
                          //     InkWell(
                          //         onTap: () {
                          //           Navigator.pushNamed(context, "/voucher");
                          //         },
                          //         child:
                          //             Icon(Icons.keyboard_arrow_right_rounded))
                          //   ],
                          // ),
                          // Divider(
                          //   height: 20,
                          // ),
                        ],
                      ),
                    ),
                    Container(
                      height: 4,
                      color: const Color(0xffEFEBE9),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(AppDimen.screenPadding),
                      child: Column(
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
                                "Price",
                                style: AppStyle.normalTextStyleDark
                                    .copyWith(fontWeight: FontWeight.w400),
                              ),
                              Text(
                                FormatUtil.formatMoney(state.cart.totalPrice),
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
                                FormatUtil.formatMoney(state.cart.shippingFee!),
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
                                FormatUtil.formatMoney(state.cart.totalPrice +
                                    state.cart.shippingFee!),
                                style: AppStyle.mediumTitleStyleDark,
                              )
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              bottomNavigationBar: BottomAppBar(
                  height: 70,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: AppDimen.screenPadding),
                    child: ElevatedButton(
                      onPressed: state.isValid
                          ? () {
                              context
                                  .read<CartBloc>()
                                  .add(CartCreateShippingOrder());
                            }
                          : null,
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40))),
                      child: Text(
                          "Order (${FormatUtil.formatMoney(state.cart.totalPrice + state.cart.shippingFee!)})"),
                    ),
                  )),
            );
          }
        } else {
          return const SizedBox();
        }
      },
    );
  }

  Widget buildAddressDetail(CartLoaded state, BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigator.pushNamed(context, AppRouter.savedAddressRoute,
        //     arguments: true)
        //     .then((value) =>
        //     context.read<CartBloc>().add(ChooseAddress(value as String)));
      },
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      state.cart.address!.recipientName!,
                      style: AppStyle.mediumTextStyleDark
                          .copyWith(color: AppColor.headingColor),
                    ),
                    Text(
                      "  |  ",
                      style: AppStyle.normalTextStyleDark,
                    ),
                    Text(
                      state.cart.address!.phoneNumber!,
                      style: AppStyle.normalTextStyleDark,
                    ),
                  ],
                ),
                Text(
                  state.cart.address!.details!,
                  style: AppStyle.normalTextStyleDark,
                ),
              ],
            ),
          ),
          const SizedBox(
            width: 40,
          ),
          const Icon(Icons.keyboard_arrow_right_rounded),
        ],
      ),
    );
  }

  Widget buildPaymentMethod(CartLoaded state, BuildContext context) {
    return GestureDetector(
      onTap: () {
        buildShowPaymentBottomSheet(context);
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Payment Method",
                style: AppStyle.mediumTitleStyleDark.copyWith(
                    color: AppColor.headingColor, fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 4,
              ),
              Builder(builder: (context) {
                if (state.cart.typePayment == PaymentType.CASHING) {
                  return Row(
                    children: [
                      Image.asset(
                        AppPath.icCash,
                        width: 24,
                        height: 24,
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      Text("Cash", style: AppStyle.normalTextStyleDark),
                    ],
                  );
                } else {
                  return Row(
                    children: [
                      Image.asset(
                        AppPath.icVnPay,
                        width: 24,
                        height: 24,
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      Text("VNPay", style: AppStyle.normalTextStyleDark),
                    ],
                  );
                }
              }),
            ],
          ),
          const Icon(Icons.keyboard_arrow_right_rounded)
        ],
      ),
    );
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

Future<void> buildShowPaymentBottomSheet(BuildContext context) {
  return showModalBottomSheet<void>(
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20), topRight: Radius.circular(20)),
    ),
    context: context,
    builder: (BuildContext context) {
      return const PaymentBottomSheet();
    },
  );
}
