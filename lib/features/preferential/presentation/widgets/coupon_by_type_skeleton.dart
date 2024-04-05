part of preferential;

class CouponByTypeSkeleton extends StatelessWidget {
  const CouponByTypeSkeleton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PhysicalShape(
      color: Colors.white,
      elevation: 4,
      shadowColor: const Color(0xFFE4E4E4).withOpacity(0.5),
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
                    child: MyShimmerRectangle(
                      width: MediaQuery.of(context).size.width * 3 / 10 + 4,
                      height: MediaQuery.of(context).size.width * 3 / 10 + 4,
                    ),
                  ),
                  DottedLine(
                    direction: Axis.vertical,
                    dashLength: 8.0,
                    dashColor: AppColor.dividerColor,
                  ),
                  const Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: AppDimen.spacing,
                          horizontal: AppDimen.smallPadding),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          MyShimmerRectangle(
                            width: 150,
                            height: 20,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              MyShimmerRectangle(
                                width: 60,
                                height: 12,
                              ),
                              SizedBox(
                                height: AppDimen.smallSpacing,
                              ),
                              MyShimmerRectangle(
                                width: 60,
                                height: 12,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: AppDimen.spacing,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
