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
      _bloc.add(CouponInCartLoadInformation(cart: cart));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => _bloc,
        child: BlocListener<CouponInCartBloc, CouponInCartState>(
          listener: (context, state) {
            if (state is CouponInCartLoadSuccess) {
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
                                type: CouponType.SHIPPING),
                            SizedBox(height: AppDimen.smallPadding,),
                            CouponInformationList(
                                couponInformationList: productCouponList,
                                type: CouponType.PRODUCT),
                            SizedBox(height: AppDimen.smallPadding,),
                            CouponInformationList(
                                couponInformationList: orderCouponList,
                                type: CouponType.ORDER),
                            SizedBox(height: AppDimen.smallPadding,),
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
          ),
        ));
  }
}
