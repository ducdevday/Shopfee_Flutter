part of coupon_detail;

class CouponDetailLoadingWidget extends StatelessWidget {
  const CouponDetailLoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              children: [
                Lottie.asset(
                  AppPath.imgCouponLoading,
                  width: AppDimen.mediumImageSize,
                  height: AppDimen.mediumImageSize,
                ),
                Positioned(
                    bottom: AppDimen.spacing,
                    right: 0,
                    left: AppDimen.spacing,
                    child: Center(
                        child: Text(
                      "Loading...",
                      style: AppStyle.mediumTextStyleDark
                          .copyWith(color: AppColor.primaryColor),
                    )))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
