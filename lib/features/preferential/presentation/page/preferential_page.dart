part of preferential;

class PreferentialPage extends StatelessWidget {
  static const int page = 3;

  const PreferentialPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RefreshConfiguration.copyAncestor(
      context: context,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(R.preferential.tr()),
          bottom: const PreferredSize(
            preferredSize: Size.fromHeight(1),
            child: Divider(height: 1),
          ),
          automaticallyImplyLeading: true,
        ),
        backgroundColor: AppColor.scaffoldColorBackground,
        body: Padding(
          padding: const EdgeInsets.all(AppDimen.spacing),
          child: Column(
            children: [
              Stack(
                children: [
                  Image.asset(AppPath.imgCoinBackground),
                  Positioned.fill(
                    left: AppDimen.screenPadding,
                    child: BlocBuilder<UserBloc, UserState>(
                      builder: (context, state) {
                        switch (state) {
                          case UserInitial():
                            return Row(
                              children: [
                                InkWell(
                                  onTap: () {
                                    NavigationUtil.pushNamed(LoginPage.route,
                                        arguments: DefaultPage.route);
                                  },
                                  child: Text(
                                    R.loginOrRegister.tr(),
                                    style: AppStyle.mediumTitleStylePrimary
                                        .copyWith(
                                            color: AppColor.secondaryColor),
                                  ),
                                ),
                              ],
                            );
                          case UserLoadSuccess():
                            return GestureDetector(
                              onTap: () {
                                NavigationUtil.pushNamed(CoinPage.route,
                                    arguments: SharedService.getUserId()!);
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "${R.yourCoin.tr()}: ${state.user.coin}",
                                        style: AppStyle.mediumTitleStylePrimary
                                            .copyWith(
                                                color: AppColor.secondaryColor),
                                      ),
                                      const SizedBox(
                                        width: 4,
                                      ),
                                      Image.asset(
                                        AppPath.icCoin,
                                        width: 24,
                                        height: 24,
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        R.tapToSeeHistory.tr(),
                                        style: AppStyle.mediumTitleStylePrimary
                                            .copyWith(
                                                color: AppColor.secondaryColor),
                                      ),
                                      Icon(
                                        Icons.arrow_forward_ios_rounded,
                                        color: AppColor.secondaryColor,
                                      )
                                    ],
                                  )
                                ],
                              ),
                            );
                          default:
                            return const SizedBox();
                        }
                      },
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: AppDimen.smallSize,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        R.newCoupon.tr(),
                        style: AppStyle.mediumTextStyleDark,
                      ),
                      Text(
                        R.tapToSeeDetail.tr(),
                        style: AppStyle.smallTextStyleDark,
                      )
                    ],
                  ),
                  OutlinedButton(
                    onPressed: () {
                      NavigationUtil.pushNamed(CouponPage.route);
                    },
                    child: Text(R.allCoupon.tr()),
                    style: AppStyle.outlineSmallButtonStylePrimary,
                  )
                ],
              ),
              BlocBuilder<PreferentialBloc, PreferentialState>(
                builder: (context, state) {
                  switch (state) {
                    case PreferentialLoadInProcess():
                      return Expanded(child: const CouponSkeletonList());
                    case PreferentialLoadSuccess():
                      if (state.coupons.isNotEmpty) {
                        return Expanded(
                            child: CouponByTypeList(coupons: state.coupons));
                      } else {
                        return Expanded(
                          child: MyEmptyList(
                              imgPath: AppPath.icNoCoupon,
                              text: R.noCouponFound.tr()),
                        );
                      }
                    case PreferentialLoadFailure():
                      return Expanded(child: const MyErrorWidget());
                    default:
                      return const SizedBox();
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
