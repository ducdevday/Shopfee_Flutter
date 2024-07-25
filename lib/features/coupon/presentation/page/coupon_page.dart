part of coupon;

class CouponPage extends StatefulWidget {
  static const String route = "/coupon";

  const CouponPage({Key? key}) : super(key: key);

  @override
  State<CouponPage> createState() => _CouponPageState();
}

class _CouponPageState extends State<CouponPage> {
  late final CouponBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = ServiceLocator.sl<CouponBloc>()..add(CouponLoadInformation());
  }

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: BlocProvider(
        create: (context) => _bloc,
        child: Scaffold(
          backgroundColor: const Color(0xffEFEBE9),
          appBar: AppBar(
            title: Text(R.allCoupon.tr()),
            backgroundColor: Colors.white,
            centerTitle: true,
            bottom: TabBar(
                padding: EdgeInsets.zero,
                unselectedLabelColor: AppColor.disableColor,
                indicatorColor: AppColor.primaryColor,
                indicatorSize: TabBarIndicatorSize.tab,
                labelColor: AppColor.primaryColor,
                tabs: CouponType.values
                    .mapIndexed((index, e) => Tab(
                          child: badges.Badge(
                            badgeAnimation: badges.BadgeAnimation.scale(
                              animationDuration: Duration(seconds: 1),
                              colorChangeAnimationDuration: Duration(seconds: 1),
                              loopAnimation: false,
                              curve: Curves.fastOutSlowIn,
                              colorChangeAnimationCurve: Curves.easeInCubic,
                            ),
                            badgeContent: BlocBuilder<CouponBloc, CouponState>(
                              builder: (context, state) {
                                if (state is CouponLoadSuccess) {
                                  return Text(
                                    "${state.getCouponListLengthByType(e)}",
                                    style: AppStyle.normalTextStyle,
                                  );
                                }
                                return SizedBox();
                              },
                            ),
                            badgeStyle: badges.BadgeStyle(
                                badgeColor: AppColor.primaryColor),
                            position:
                                badges.BadgePosition.topEnd(top: -20, end: -16),
                            child: Text(
                              e.name,
                              style: AppStyle.mediumTextStyleDark,
                            ),
                          ),
                        ))
                    .toList()),
          ),
          body: const Padding(
            padding: EdgeInsets.all(AppDimen.spacing),
            child: TabBarView(
              children: [
                CouponByTypeTabview(couponType: CouponType.SHIPPING),
                CouponByTypeTabview(couponType: CouponType.ORDER),
                CouponByTypeTabview(couponType: CouponType.PRODUCT),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
