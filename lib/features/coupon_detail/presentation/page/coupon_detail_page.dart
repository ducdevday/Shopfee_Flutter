part of coupon_detail;

class CouponDetailPage extends StatefulWidget {
  static const String route = "/coupon_detail";
  final String couponId;

  const CouponDetailPage({Key? key, required this.couponId}) : super(key: key);

  @override
  State<CouponDetailPage> createState() => _CouponDetailPageState();
}

class _CouponDetailPageState extends State<CouponDetailPage> {
  late CouponDetailBloc _bloc;

  double couponSize = AppDimen.largeCouponSize;
  int divisions = 11;

  @override
  void initState() {
    super.initState();
    _bloc = ServiceLocator.sl<CouponDetailBloc>()
      ..add(CouponDetailLoadInformation(couponId: widget.couponId));
  }

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _bloc,
      child: BlocConsumer<CouponDetailBloc, CouponDetailState>(
        listener: (context, state) {},
        builder: (context, state) {
          switch (state) {
            case CouponDetailLoadInProcess():
              return CouponDetailLoadingWidget();
            case CouponDetailLoadSuccess():
              return Scaffold(
                backgroundColor: AppColor.scaffoldColorBackground,
                body: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: AppDimen.screenPadding,
                        right: AppDimen.screenPadding,
                        bottom: AppDimen.screenPadding),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: AppDimen.screenPadding * 2,
                                bottom: AppDimen.screenPadding),
                            child: InkWell(
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () {
                                NavigationUtil.pop();
                              },
                              child: Icon(Icons.close_rounded),
                            ),
                          ),
                        ),
                        PhysicalShape(
                          color: Colors.white,
                          elevation: 4,
                          shadowColor: const Color(0xFFE4E4E4).withOpacity(0.5),
                          clipper: CouponClipperVertical(divisions: divisions),
                          child: Stack(
                            children: <Widget>[
                              ClipPath(
                                clipper:
                                    CouponClipperVertical(divisions: divisions),
                                child: SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  height: couponSize,
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: couponSize * 2 / divisions,
                                        child: Padding(
                                          padding: const EdgeInsets.all(
                                              AppDimen.spacing),
                                          child: Column(
                                            children: [
                                              Text(
                                                "Shopfee",
                                                style: AppStyle
                                                    .normalTextStyleDark,
                                              ),
                                              SizedBox(
                                                height: AppDimen.spacing,
                                              ),
                                              Expanded(
                                                child: Text(
                                                  "${state.coupon.description}${state.coupon.description}${state.coupon.description}${state.coupon.description}",
                                                  style: AppStyle
                                                      .mediumTitleStyleDark,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      DottedLine(
                                        direction: Axis.horizontal,
                                        dashLength: 8.0,
                                        dashColor: AppColor.dividerColor,
                                      ),
                                      SizedBox(
                                        height: couponSize * 5 / divisions,
                                        child: Padding(
                                          padding:
                                              EdgeInsets.all(AppDimen.spacing),
                                          child: Column(
                                            children: [
                                              Image.asset(
                                                AppPath.imgQRCode,
                                                width: 150,
                                                height: 150,
                                              ),
                                              Text(
                                                "Code: ${state.coupon.code}",
                                                style: AppStyle
                                                    .mediumTextStyleDark,
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      DottedLine(
                                        direction: Axis.horizontal,
                                        dashLength: 8.0,
                                        dashColor: AppColor.dividerColor,
                                      ),
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: SizedBox(
                                            height:
                                                couponSize * 4 / divisions - 12,
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: AppDimen.spacing,
                                                  horizontal:
                                                      AppDimen.smallPadding),
                                              child: SingleChildScrollView(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "Expire",
                                                      style: AppStyle
                                                          .normalTextStyleDark
                                                          .copyWith(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                    ),
                                                    Text(
                                                      "${FormatUtil.formatDate(state.coupon.startDate)} - ${FormatUtil.formatDate(state.coupon.expirationDate)}",
                                                      style: AppStyle
                                                          .smallTextStyleDark,
                                                    ),
                                                    SizedBox(
                                                      height:
                                                          AppDimen.smallSpacing,
                                                    ),
                                                    Text(
                                                      "Condition",
                                                      style: AppStyle
                                                          .normalTextStyleDark
                                                          .copyWith(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                    ),
                                                    Text(
                                                        "${state.coupon.conditionListString()}",
                                                        style: AppStyle
                                                            .smallTextStyleDark)
                                                  ],
                                                ),
                                              ),
                                            )),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            case CouponDetailLoadFailure():
              return MyErrorWidget();
            default:
              return SizedBox();
          }
        },
      ),
    );
  }
}

class CouponClipperVertical extends CustomClipper<Path> {
  final int divisions;

  CouponClipperVertical({super.reclip, required this.divisions});

  //! Change size.height * 2 && size.height * 7 to change position of haft circle
  @override
  Path getClip(Size size) {
    final Path path = Path();

    path.lineTo(size.width - 10, 0);
    path.quadraticBezierTo(size.width, 0.0, size.width, 10.0);
    path.lineTo(size.width, size.height * 2 / divisions);
    path.relativeArcToPoint(const Offset(0, 20),
        radius: const Radius.circular(10.0), largeArc: true, clockwise: false);
    path.lineTo(size.width, size.height * 7 / divisions);
    path.relativeArcToPoint(const Offset(0, 20),
        radius: const Radius.circular(10.0), largeArc: true, clockwise: false);
    path.lineTo(size.width, size.height - 10);
    path.quadraticBezierTo(
        size.width, size.height, size.width - 10, size.height);
    path.lineTo(10, size.height);
    path.quadraticBezierTo(0.0, size.height, 0.0, size.height - 10);
    path.lineTo(0, size.height * 7 / divisions + 20);
    path.arcToPoint(Offset(0, size.height * 7 / divisions),
        radius: const Radius.circular(10.0), clockwise: false);
    path.lineTo(0, size.height * 2 / divisions + 20);
    path.arcToPoint(Offset(0, size.height * 2 / divisions),
        radius: const Radius.circular(10.0), clockwise: false);
    path.lineTo(0.0, 10.0);
    path.quadraticBezierTo(0.0, 0.0, 10.0, 0.0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
