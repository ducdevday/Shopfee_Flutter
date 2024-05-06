part of coupon;

class CouponByTypeTabview extends StatefulWidget {
  final CouponType couponType;

  const CouponByTypeTabview({Key? key, required this.couponType})
      : super(key: key);

  @override
  State<CouponByTypeTabview> createState() => _CouponByTypeTabviewState();
}

class _CouponByTypeTabviewState extends State<CouponByTypeTabview>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocBuilder<CouponBloc, CouponState>(
      builder: (context, state) {
        switch (state) {
          case CouponLoadInProcess():
            return const CouponSkeletonList();
          case CouponLoadSuccess():
            final couponList = state.getCouponListByType(widget.couponType);
            if (couponList.isNotEmpty) {
              return CouponByTypeList(coupons: couponList);
            } else {
              return const MyEmptyList(
                  imgPath: AppPath.icNoCoupon, text: "No Coupon Found");
            }
          case CouponLoadFailure():
            return const MyErrorWidget();
          default:
            return const SizedBox();
        }
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
