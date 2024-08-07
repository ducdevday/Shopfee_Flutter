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
    final userState = context.read<UserBloc>().state;
    if (userState is UserLoadSuccess) {
      final ReceiverOnsiteEntity receiverInformation = ReceiverOnsiteEntity(
          recipientName:
              "${userState.user.firstName} ${userState.user.lastName}",
          phoneNumber: userState.user.phoneNumber);
      context.read<CartBloc>().add(
          CartInitAddressAndReceiver(receiverInformation: receiverInformation));
    }
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
              backgroundColor: AppColor.scaffoldColorBackground,
              appBar: AppBar(
                title: Text(R.cart.tr()),
                centerTitle: true,
                bottom: const PreferredSize(
                  preferredSize: Size.fromHeight(1),
                  child: Divider(height: 1),
                ),
                backgroundColor: Colors.white,
                actions: [
                  IconButton(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext dialogContext) =>
                                MyConfirmDialog(
                                  title: R.confirm.tr(),
                                  content:
                                      R.deleteAll.tr(),
                                  callbackOK: () {
                                    context
                                        .read<CartBloc>()
                                        .add(CartDeleteInformation());
                                    Navigator.pop(dialogContext);
                                  },
                                  callbackCancel: () {
                                    Navigator.pop(dialogContext);
                                  },
                                  confirmText: R.delete.tr(),
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
                    SizedBox(
                      height: 4,
                    ),
                    const ProductChosenList(),
                    SizedBox(
                      height: 4,
                    ),
                    BlocBuilder<UserBloc, UserState>(
                      builder: (context, userState) {
                        if (userState is UserLoadSuccess) {
                          return Column(
                            children: [
                              const ProductGiftList(),
                              CartItemContainerWidget(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                            child: buildOrderTypeText(state)),
                                        TextButton(
                                          child: Text(
                                            R.change.tr(),
                                            style:
                                                AppStyle.normalTextStylePrimary,
                                          ),
                                          onPressed: () {
                                            buildShowDeliveryBottomSheet(
                                                context);
                                          },
                                        )
                                      ],
                                    ),
                                    const AddressShippingWidget(),
                                    const StoreWidget(),
                                    const ReceiverInformationWidget(),
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
                                            borderRadius:
                                                BorderRadius.circular(8)),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                color: Color(0xffCCCCCC)),
                                            borderRadius:
                                                BorderRadius.circular(8)),
                                        hintText: R.addNoteForShop.tr(),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 4,
                              ),
                              const CartItemContainerWidget(
                                child: PaymentMethod(),
                              ),
                              SizedBox(
                                height: 4,
                              ),
                              const CartItemContainerWidget(
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
                              SizedBox(
                                height: 4,
                              ),
                              const CartItemContainerWidget(
                                child: PaymentSummary(),
                              ),
                            ],
                          );
                        } else {
                          return SizedBox();
                        }
                      },
                    ),
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
      return Text(R.homeDelivery.tr(),
          style: AppStyle.mediumTitleStyleDark
              .copyWith(color: AppColor.headingColor));
    } else {
      return Text(R.takeAway.tr(),
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
                  R.cartEmpty.tr(),
                  style: AppStyle.largeTitleStyleDark,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  R.noProductAdded.tr(),
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
                child:  Text(R.orderNow.tr()),
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

Future<void> buildShowBranchShippingBottomSheet(BuildContext context) {
  return showModalBottomSheet<void>(
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20), topRight: Radius.circular(20)),
    ),
    context: context,
    builder: (BuildContext context) {
      return const BranchConflictBottomSheet();
    },
  );
}
