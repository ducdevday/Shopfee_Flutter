part of store_detail;

class StoreDetailPage extends StatefulWidget {
  static const String route = "/store_detail";
  final String branchId;

  const StoreDetailPage({Key? key, required this.branchId}) : super(key: key);

  @override
  State<StoreDetailPage> createState() => _StoreDetailPageState();
}

class _StoreDetailPageState extends State<StoreDetailPage> {
  late final StoreDetailBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = ServiceLocator.sl<StoreDetailBloc>()
      ..add(StoreDetailLoadInformation(branchId: widget.branchId));
  }

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }

  Future<void> _makeDirectLocation(
      {required double latitude, required double longitude}) async {
    String googleUrl =
        'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    if (await canLaunchUrl(Uri.parse(googleUrl))) {
      await launchUrl(Uri.parse(googleUrl));
    } else {
      throw 'Could not launch $googleUrl';
    }
  }

  Future<void> _makePhoneCall({required String phoneNumber}) async {
    String telQuery = "tel: $phoneNumber";
    if (await canLaunchUrl(Uri.parse(telQuery))) {
      await launchUrl(Uri.parse(telQuery));
    } else {
      throw 'Could not launch $telQuery';
    }
  }

  Future<void> _makeShareLocation(
      {required String address,
      required double latitude,
      required double longitude}) async {
    final result = await Share.shareWithResult(
        "$address https://www.google.com/maps/dir/Current+Location/$latitude,$longitude");
    if (result.status == ShareResultStatus.success) {
      AlertUtil.showToast(R.shareSuccess.tr());
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _bloc,
      child: BlocBuilder<StoreDetailBloc, StoreDetailState>(
        builder: (context, state) {
          switch (state) {
            case StoreDetailLoadInProcess():
              return const StoreDetailLoadingPage();
            case StoreDetailLoadSuccess():
              return Scaffold(
                body: Column(
                  children: [
                    Stack(
                      children: [
                        GestureDetector(
                          onTap: () {
                            NavigationUtil.pushNamed(
                                NetworkImageFullScreen.route,
                                arguments: state.store.imageUrl!);
                          },
                          child: Hero(
                            tag: "IMG",
                            child: CachedNetworkImage(
                              imageUrl: "${state.store.imageUrl}",
                              fit: BoxFit.cover,
                              width: MediaQuery.of(context).size.width,
                              placeholder: (context, url) =>
                                  MyPlaceHolderRectangle(
                                width: MediaQuery.of(context).size.width,
                                height: 270,
                              ),
                              errorWidget: (_, __, ___) => Image.asset(
                                AppPath.imgImageError,
                                width: MediaQuery.of(context).size.width,
                                height: 270,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                            top: 36,
                            left: AppDimen.screenPadding,
                            child: Hero(
                              tag: "close_button",
                              child: Container(
                                  width: 32,
                                  height: 32,
                                  decoration: BoxDecoration(
                                    color: AppColor.disableColor,
                                    shape: BoxShape.circle,
                                  ),
                                  child: IconButton(
                                    iconSize: 16,
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    icon: const Icon(
                                      Icons.close_rounded,
                                      color: Colors.white,
                                    ),
                                  )),
                            ))
                      ],
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: AppDimen.smallPadding,
                            vertical: AppDimen.spacing),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Shopfee",
                              style: AppStyle.mediumTextStyleDark,
                            ),
                            const SizedBox(
                              height: AppDimen.spacing,
                            ),
                            Text(
                              "${state.store.name}",
                              style: AppStyle.mediumTitleStyleDark,
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            Text(
                              "${R.open.tr()}: ${state.store.openTime}AM - ${state.store.closeTime}PM",
                              style: AppStyle.normalTextStyleDark,
                            )
                          ],
                        ),
                      ),
                    ),
                    const Divider(),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: AppDimen.spacing, left: AppDimen.smallPadding),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              SvgPicture.asset(AppPath.icDirect),
                              const SizedBox(
                                width: AppDimen.spacing,
                              ),
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    _makeDirectLocation(
                                        latitude: state.store.latitude!,
                                        longitude: state.store.longitude!);
                                  },
                                  child: Text(
                                    "${state.store.fullAddress}",
                                    style: AppStyle.normalTextStyleDark,
                                    overflow: TextOverflow.clip,
                                  ),
                                ),
                              )
                            ],
                          ),
                          const Divider(
                            indent: 45,
                            height: 30,
                          ),
                          Row(
                            children: [
                              SvgPicture.asset(AppPath.icPhone),
                              const SizedBox(
                                width: AppDimen.spacing,
                              ),
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext contextDialog) =>
                                            MyConfirmDialog(
                                                title: R.callTo.tr(),
                                                content:
                                                    "${state.store.phoneNumber}",
                                                callbackOK: () async {
                                                  await _makePhoneCall(
                                                          phoneNumber: state
                                                              .store
                                                              .phoneNumber!)
                                                      .then((value) =>
                                                          Navigator.pop(
                                                              contextDialog));
                                                },
                                                callbackCancel: () {
                                                  Navigator.pop(contextDialog);
                                                }));
                                  },
                                  child: Text(
                                    "${state.store.phoneNumber}",
                                    style: AppStyle.normalTextStyleDark,
                                    overflow: TextOverflow.clip,
                                  ),
                                ),
                              )
                            ],
                          ),
                          const Divider(
                            indent: 45,
                            height: 30,
                          ),
                          Row(
                            children: [
                              SvgPicture.asset(AppPath.icShare),
                              const SizedBox(
                                width: AppDimen.spacing,
                              ),
                              Expanded(
                                child: GestureDetector(
                                  onTap: () async {
                                    _makeShareLocation(
                                        address: "${state.store.fullAddress}",
                                        latitude: state.store.latitude!,
                                        longitude: state.store.longitude!);
                                  },
                                  child: Text(
                                    R.shareToYourFriend.tr(),
                                    style: AppStyle.normalTextStyleDark,
                                    overflow: TextOverflow.clip,
                                  ),
                                ),
                              )
                            ],
                          ),
                          const Divider(
                            indent: 45,
                            height: 30,
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.all(AppDimen.screenPadding),
                      child: ElevatedButton(
                        onPressed: () {
                          NavigationUtil.pop();
                          context
                              .read<MyBottomNavBarCubit>()
                              .selectPage(OrderPage.indexPage);
                          context.read<OrderBloc>().add(OrderApplyFilter(
                              initPage: 1,
                              initSize: 8,
                              branchId: widget.branchId));
                        },
                        style: AppStyle.elevatedButtonStylePrimary,
                        child: Text(R.orderProduct.tr()),
                      ),
                    )
                  ],
                ),
              );
            case StoreDetailLoadFailure():
              return const MyErrorPage();
            default:
              return const SizedBox();
          }
        },
      ),
    );
  }
}
