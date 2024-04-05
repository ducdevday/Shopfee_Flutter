part of coupon_in_cart;

class CouponInCartPage extends StatefulWidget {
  static const String route = "/coupon_in_cart";

  const CouponInCartPage({Key? key}) : super(key: key);

  @override
  State<CouponInCartPage> createState() => _CouponInCartPageState();
}

class _CouponInCartPageState extends State<CouponInCartPage> {
  late CouponInCartBloc _bloc;
  late CartEntity cart;

  List<CouponType> noShippingWithCoupon = [];
  List<CouponType> noOrderWithCoupon = [];
  List<CouponType> noProductWithCoupon = [];
  List<CouponInformationEntity> shippingCouponList = [];
  List<CouponInformationEntity> orderCouponList = [];
  List<CouponInformationEntity> productCouponList = [];

  @override
  void initState() {
    super.initState();
    _bloc = ServiceLocator.sl<CouponInCartBloc>();
    final cartState = context.read<CartBloc>().state;
    if (cartState is CartLoaded) {
      cart = cartState.cart;
      _bloc.add(CouponInCartLoadInitInformation(
          cart: cart,
          shippingCouponChosenCode: cart.shippingCouponCode,
          orderCouponChosenCode: cart.orderCouponCode,
          productCouponChosenCode: cart.productCouponCode));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => _bloc,
        child: BlocListener<CouponInCartBloc, CouponInCartState>(
          listener: (context, state) {
            if (state is CouponInCartLoadSuccess) {
              noShippingWithCoupon =
                  state.couponInCart.noShippingWithCoupon ?? [];
              noOrderWithCoupon = state.couponInCart.noOrderWithCoupon ?? [];
              noProductWithCoupon =
                  state.couponInCart.noProductWithCoupon ?? [];
              shippingCouponList = state.couponInCart.shippingCouponList ?? [];
              orderCouponList = state.couponInCart.orderCouponList ?? [];
              productCouponList = state.couponInCart.productCouponList ?? [];
            }
          },
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              title: Text("Choose Coupon"),
              bottom: const PreferredSize(
                preferredSize: Size.fromHeight(1),
                child: Divider(height: 1),
              ),
            ),
            backgroundColor: AppColor.scaffoldColorBackground,
            body: Padding(
              padding: EdgeInsets.all(AppDimen.spacing),
              child: BlocBuilder<CouponInCartBloc, CouponInCartState>(
                builder: (context, state) {
                  switch (state) {
                    case CouponInCartLoadInProcess():
                      return Center(child: CupertinoActivityIndicator());
                    case CouponInCartLoadSuccess():
                      return SingleChildScrollView(
                        child: Column(
                          children: [
                            CouponInformationList(
                                couponInformationList: shippingCouponList,
                                conflictList: noShippingWithCoupon,
                                type: CouponType.SHIPPING),
                            SizedBox(
                              height: AppDimen.smallPadding,
                            ),
                            CouponInformationList(
                                couponInformationList: orderCouponList,
                                conflictList: noOrderWithCoupon,
                                type: CouponType.ORDER),
                            SizedBox(
                              height: AppDimen.smallPadding,
                            ),
                            CouponInformationList(
                                couponInformationList: productCouponList,
                                conflictList: noProductWithCoupon,
                                type: CouponType.PRODUCT),
                            SizedBox(
                              height: AppDimen.smallPadding,
                            ),
                          ],
                        ),
                      );
                    case CouponInCartLoadFailure():
                      return MyErrorWidget();
                    default:
                      return SizedBox();
                  }
                },
              ),
            ),
            bottomNavigationBar: BottomAppBar(
              height: 70,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppDimen.screenPadding,
                ),
                child: BlocBuilder<CouponInCartBloc, CouponInCartState>(
                  builder: (context, state) {
                    if (state is CouponInCartLoadSuccess) {
                      return ElevatedButton(
                        onPressed: () {
                          context.read<CartBloc>().add(CartUpdateChosenCoupon(
                              shippingCouponChosenCode:
                                  state.shippingCouponChosenCode,
                              orderCouponChosenCode:
                                  state.orderCouponChosenCode,
                              productCouponChosenCode:
                                  state.productCouponChosenCode));
                          NavigationUtil.pop();
                        },
                        style: AppStyle.elevatedButtonStylePrimary,
                        child: Text("Confirm"),
                      );
                    }
                    return ElevatedButton(
                      onPressed: null,
                      style: AppStyle.elevatedButtonStylePrimary,
                      child: Text("Confirm"),
                    );
                  },
                ),
              ),
            ),
          ),
        ));
  }
}
