part of coupon_in_cart;

class CouponInformationList extends StatelessWidget {
  final List<CouponInformationEntity> couponInformationList;
  final List<CouponType> conflictList;
  final CouponType type;

  const CouponInformationList(
      {Key? key,
      required this.couponInformationList,
      required this.conflictList,
      required this.type})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return couponInformationList.isNotEmpty
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                type.getTitle(),
                style: AppStyle.mediumTextStyleDark,
              ),
              // if (canChooseCoupon)
              Text(
                "You can choose 1 coupon",
                style: AppStyle.smallTextStyleDark,
              ),
              SizedBox(
                height: AppDimen.spacing,
              ),
              ListView.separated(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) => CouponInformationItem(
                      coupon: couponInformationList[index], type: type),
                  separatorBuilder: (context, index) => SizedBox(
                        height: AppDimen.spacing,
                      ),
                  itemCount: couponInformationList.length),
            ],
          )
        : SizedBox();
  }
}
