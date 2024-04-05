part of preferential;

class CouponByTypeList extends StatelessWidget {
  final List<CouponByTypeEntity> coupons;

  const CouponByTypeList({Key? key, required this.coupons}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        padding: EdgeInsets.only(
            top: AppDimen.spacing,),
        itemBuilder: (context, index) =>
            CouponByTypeItem(coupon: coupons[index]),
        separatorBuilder: (context, index) => SizedBox(
              height: AppDimen.spacing,
            ),
        itemCount: coupons.length);
  }
}
