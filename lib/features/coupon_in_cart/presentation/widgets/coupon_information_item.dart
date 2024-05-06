part of coupon_in_cart;

class CouponInformationItem extends StatefulWidget {
  final CouponInformationEntity coupon;
  final CouponType type;

  const CouponInformationItem(
      {Key? key, required this.coupon, required this.type})
      : super(key: key);

  @override
  State<CouponInformationItem> createState() => _CouponInformationItemState();
}

class _CouponInformationItemState extends State<CouponInformationItem> {
  final ExpansionTileController controller = ExpansionTileController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CouponInCartBloc, CouponInCartState>(
      builder: (context, state) {
        if (state is CouponInCartLoadSuccess) {
          final String? currentCoupon;
          switch (widget.type) {
            case CouponType.SHIPPING:
              currentCoupon = state.shippingCouponChosenCode;
              break;
            case CouponType.ORDER:
              currentCoupon = state.orderCouponChosenCode;
              break;
            case CouponType.PRODUCT:
              currentCoupon = state.productCouponChosenCode;
              break;
          }
          return Column(
            children: [
              Stack(
                children: [
                  InkWell(
                    onTap: () {

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
                              width: MediaQuery
                                  .of(context)
                                  .size
                                  .width,
                              height: 120,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10.0)),
                              child: Row(
                                children: [
                                  Container(
                                    padding:
                                    const EdgeInsets.all(AppDimen.smallPadding),
                                    width:
                                    MediaQuery
                                        .of(context)
                                        .size
                                        .width * 3 / 10 +
                                        4,
                                    child: Image.asset(
                                      widget.type.getImage(),
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
                                        crossAxisAlignment: CrossAxisAlignment
                                            .start,
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "${widget.coupon.description}",
                                            style: AppStyle.mediumTextStyleDark,
                                          ),
                                          Text(
                                            "Expire: ${FormatUtil.formatDate2(
                                                widget.coupon.expirationDate)}",
                                            style: AppStyle.smallTextStyleDark,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  MyRadio<String?>(value: widget.coupon.code,
                                      groupValue: currentCoupon,
                                      onChanged: (String? value) {
                                        context.read<CouponInCartBloc>().add(
                                            CouponInCartChooseItem(
                                                couponCode: value,
                                                couponType: widget.type));
                                      }),
                                  SizedBox(width: AppDimen.spacing,)
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (widget.coupon.valid == false)
                    Positioned.fill(
                        child: PhysicalShape(
                          color: Colors.white.withOpacity(0.4),
                          shadowColor: Color(0xFFE4E4E4).withOpacity(0.5),
                          clipper: CouponClipperHorizontal(),
                          child: Stack(
                            children: <Widget>[
                              ClipPath(
                                clipper: CouponClipperHorizontal(),
                                child: Container(
                                  width: MediaQuery
                                      .of(context)
                                      .size
                                      .width,
                                  height: 120,
                                  decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.4),
                                      borderRadius: BorderRadius.circular(
                                          10.0)),
                                ),
                              ),
                            ],
                          ),
                        )),
                ],
              ),
              if (widget.coupon.valid == false && widget.coupon.haveConditionList())
                ExpansionTile(
                  controller: controller,
                  tilePadding: EdgeInsets.zero,
                  backgroundColor: Colors.transparent,
                  collapsedBackgroundColor: Colors.transparent,
                  shape: Border(),
                  title: Row(
                      crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Icon(
                      Icons.info_outline_rounded,
                      color: AppColor.error,
                    ),
                    SizedBox(
                      width: AppDimen.smallSpacing,
                    ),
                    Expanded(
                        child: Text(
                          'Coupon cannot be applied due to some condition',
                          style: AppStyle.smallTextStyleDark,
                        )),
                  ]),
                  children: <Widget>[
                    if (widget.coupon.minPurchaseCondition != null)
                      Padding(
                        padding: const EdgeInsets.only(
                            bottom: AppDimen.smallSpacing),
                        child: Row(
                          children: [
                            Image.asset(
                              AppPath.minPurchaseCondition,
                              width: AppDimen.smallSize,
                              height: AppDimen.smallSize,
                            ),
                            SizedBox(
                              width: AppDimen.smallSpacing,
                            ),
                            Expanded(
                                child: Text(
                                  "${widget.coupon
                                      .minPurchaseConditionString()}",
                                  style: AppStyle.smallTextStyleDark,
                                ))
                          ],
                        ),
                      ),
                    if (widget.coupon.usageConditionList != null)
                      Padding(
                        padding: const EdgeInsets.only(
                            bottom: AppDimen.smallSpacing),
                        child: Row(
                          children: [
                            Image.asset(
                              AppPath.usageCondition,
                              width: AppDimen.smallSize,
                              height: AppDimen.smallSize,
                            ),
                            SizedBox(
                              width: AppDimen.smallSpacing,
                            ),
                            Expanded(
                                child: Text(
                                  "${widget.coupon.usageConditionString()}",
                                  style: AppStyle.smallTextStyleDark,
                                ))
                          ],
                        ),
                      ),
                    if (widget.coupon.subjectConditionList != null)
                      Padding(
                        padding: const EdgeInsets.only(
                            bottom: AppDimen.smallSpacing),
                        child: Row(
                          children: [
                            Image.asset(
                              AppPath.subjectConditionList,
                              width: AppDimen.smallSize,
                              height: AppDimen.smallSize,
                            ),
                            SizedBox(
                              width: AppDimen.smallSpacing,
                            ),
                            Expanded(
                                child: Text(
                                  "${widget.coupon.subjectConditionString()}",
                                  style: AppStyle.smallTextStyleDark,
                                ))
                          ],
                        ),
                      ),
                    if (widget.coupon.combinationConditionList != null)
                      Padding(
                        padding: const EdgeInsets.only(
                            bottom: AppDimen.smallSpacing),
                        child: Row(
                          children: [
                            Image.asset(
                              AppPath.combinationConditionList,
                              width: AppDimen.smallSize,
                              height: AppDimen.smallSize,
                            ),
                            SizedBox(
                              width: AppDimen.smallSpacing,
                            ),
                            Expanded(
                                child: Text(
                                  "${widget.coupon
                                      .combinationConditionString()}",
                                  style: AppStyle.smallTextStyleDark,
                                ))
                          ],
                        ),
                      )
                  ],
                ),
            ],
          );
        }
        return SizedBox();
      },
    );
  }
}

class CouponClipperHorizontal extends CustomClipper<Path> {
  //! Change size.width * 3 to change position of haft circle
  @override
  Path getClip(Size size) {
    final Path path = Path();

    path.lineTo(size.width * 3 / 10, 0.0);
    path.relativeArcToPoint(const Offset(20, 0),
        radius: const Radius.circular(10.0), largeArc: true, clockwise: false);
    path.lineTo(size.width - 10, 0);
    path.quadraticBezierTo(size.width, 0.0, size.width, 10.0);
    path.lineTo(size.width, size.height - 10);
    path.quadraticBezierTo(
        size.width, size.height, size.width - 10, size.height);
    path.lineTo(size.width * 3 / 10 + 20, size.height);
    path.arcToPoint(Offset((size.width * 3 / 10), size.height),
        radius: const Radius.circular(10.0), clockwise: false);
    path.lineTo(10.0, size.height);
    path.quadraticBezierTo(0.0, size.height, 0.0, size.height - 10);
    path.lineTo(0.0, 10.0);
    path.quadraticBezierTo(0.0, 0.0, 10.0, 0.0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}

class BorderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0
      ..color = Colors.grey.shade300;
    Path path = Path();
//    uncomment this and will get the border for all lines
    path.lineTo(size.width * 3 / 4, 0.0);
    path.relativeArcToPoint(const Offset(20, 0),
        radius: const Radius.circular(10.0), largeArc: true, clockwise: false);
    path.lineTo(size.width - 10, 0);
    path.quadraticBezierTo(size.width, 0.0, size.width, 10.0);
    path.lineTo(size.width, size.height - 10);
    path.quadraticBezierTo(
        size.width, size.height, size.width - 10, size.height);
    path.lineTo(size.width * 3 / 4 + 20, size.height);
    path.arcToPoint(Offset((size.width * 3 / 4), size.height),
        radius: const Radius.circular(10.0), clockwise: false);
    path.lineTo(10.0, size.height);
    path.quadraticBezierTo(0.0, size.height, 0.0, size.height - 10);
    path.lineTo(0.0, 10.0);
    path.quadraticBezierTo(0.0, 0.0, 10.0, 0.0);
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
