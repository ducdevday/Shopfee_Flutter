part of preferential;

class CouponByTypeItem extends StatelessWidget {
  final CouponByTypeEntity coupon;

  const CouponByTypeItem({Key? key, required this.coupon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        NavigationUtil.pushNamed(CouponDetailPage.route, arguments: coupon.id);
      },
      child: PhysicalShape(
        color: Colors.white,
        elevation: 4,
        shadowColor: Color(0xFFE4E4E4).withOpacity(0.5),
        clipper: CouponClipperHorizontal(),
        child: Stack(
          children: <Widget>[
            ClipPath(
              clipper: CouponClipperHorizontal(),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 120,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0)),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(AppDimen.smallPadding),
                      width: MediaQuery.of(context).size.width * 3 / 10 + 4,
                      child: Image.asset(
                        "${coupon.type?.getImage()}",
                        fit: BoxFit.cover,
                      ),
                    ),
                    DottedLine(
                      direction: Axis.vertical,
                      dashLength: 8.0,
                      dashColor: AppColor.dividerColor,
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: AppDimen.spacing,
                            horizontal: AppDimen.smallPadding),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "${coupon.description}",
                              style: AppStyle.mediumTextStyleDark,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Start: ${FormatUtil.formatDate2(coupon.startDate)}",
                                  style: AppStyle.smallTextStyleDark,
                                ),
                                Text(
                                  "Expire: ${FormatUtil.formatDate2(coupon.expirationDate)}",
                                  style: AppStyle.smallTextStyleDark,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: AppDimen.spacing,
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
