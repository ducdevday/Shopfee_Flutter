part of preferential;

class CouponByTypeList extends StatefulWidget {
  final List<CouponByTypeEntity> coupons;

  const CouponByTypeList({Key? key, required this.coupons}) : super(key: key);

  @override
  State<CouponByTypeList> createState() => _CouponByTypeListState();
}

class _CouponByTypeListState extends State<CouponByTypeList> {
  late final RefreshController _refreshController;
  @override
  void initState() {
    _refreshController = RefreshController(initialRefresh: false);
    super.initState();
  }

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      controller: _refreshController,
      enablePullUp: false,
      physics: BouncingScrollPhysics(),
      onRefresh: () async {
        context
            .read<PreferentialBloc>()
            .add(PreferentialRefreshTopCoupon(quantityTop: 5));
        _refreshController.refreshCompleted();
      },
      child: ListView.separated(
          padding: EdgeInsets.only(
            top: AppDimen.spacing,
          ),
          itemBuilder: (context, index) =>
              CouponByTypeItem(coupon: widget.coupons[index]),
          separatorBuilder: (context, index) => SizedBox(
                height: AppDimen.spacing,
              ),
          itemCount: widget.coupons.length),
    );
  }
}
