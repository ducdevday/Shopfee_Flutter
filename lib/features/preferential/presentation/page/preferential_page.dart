part of preferential;

class PreferentialPage extends StatelessWidget {
  static const int page = 3;
  const PreferentialPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text("Preferential"),
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Divider(height: 1),
        ),
        automaticallyImplyLeading: true,
      ),
      backgroundColor: const Color(0xffEFEBE9),
      body: Column(
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
                                "Login / Register\nTo Get Preferential",
                                style: AppStyle.mediumTitleStylePrimary
                                    .copyWith(color: AppColor.secondaryColor),
                              ),
                            ),
                          ],
                        );
                      case UserLoadSuccess():
                        return Row(
                          children: [
                            Text(
                              "Your coin: ${state.user.coin}",
                              style: AppStyle.mediumTitleStylePrimary
                                  .copyWith(color: AppColor.secondaryColor),
                            ),
                            SizedBox(width: 4,),
                            Image.asset(
                              AppPath.icCoin,
                              width: 24,
                              height: 24,
                            )
                          ],
                        );
                      default:
                        return SizedBox();
                    }
                  },
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
