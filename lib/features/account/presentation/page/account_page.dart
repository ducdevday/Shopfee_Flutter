part of account;

class AccountPage extends StatelessWidget {
  static const int page = 4;

  const AccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Theme.of(context).canvasColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Image.asset(AppPath.imgAccountBackground),
                Align(
                  alignment: Alignment.center,
                  child: UserAvatar(),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(AppDimen.screenPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BlocBuilder<UserBloc, UserState>(
                    builder: (context, state) {
                      if (state is UserLoadSuccess) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              R.account.tr(),
                              style: AppStyle.mediumTitleStyleDark,
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(16)),
                              child: Column(
                                children: [
                                  MenuItem(
                                    iconData: Icons.account_circle_outlined,
                                    content: R.personalInformation.tr(),
                                    callback: () {
                                      NavigationUtil.pushNamed(
                                          PersonalInformationPage.route);
                                    },
                                  ),
                                  const Divider(
                                    height: 1,
                                    indent: 8,
                                  ),
                                  MenuItem(
                                    iconData: Icons.vpn_key_outlined,
                                    content: R.changePassword.tr(),
                                    callback: () {
                                      NavigationUtil.pushNamed(
                                          NewPasswordPage.route);
                                    },
                                  ),
                                  const Divider(
                                    height: 1,
                                    indent: 8,
                                  ),
                                  MenuItem(
                                    iconData: Icons.bookmark_border_rounded,
                                    content: R.savedAddress.tr(),
                                    callback: () {
                                      NavigationUtil.pushNamed(
                                          SavedAddressPage.route,
                                          arguments: DefaultPage.route);
                                    },
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            Text(
                              R.activity.tr(),
                              style: AppStyle.mediumTitleStyleDark,
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(16)),
                              child: Column(
                                children: [
                                  MenuItem(
                                    iconData: Icons.history,
                                    content: R.orderHistory.tr(),
                                    callback: () {
                                      NavigationUtil.pushNamed(
                                          HistoryPage.route);
                                    },
                                  ),
                                  const Divider(
                                    height: 1,
                                    indent: 8,
                                  ),
                                  MenuItem(
                                    iconData: Icons.monetization_on_outlined,
                                    content: R.coinHistory.tr(),
                                    callback: () {
                                      NavigationUtil.pushNamed(CoinPage.route,
                                          arguments:
                                              SharedService.getUserId()!);
                                    },
                                  ),
                                  const Divider(
                                    height: 1,
                                    indent: 8,
                                  ),
                                  MenuItem(
                                    iconData: Icons.show_chart,
                                    content: R.statistics.tr(),
                                    callback: () {
                                      NavigationUtil.pushNamed(
                                          StatisticsPage.route);
                                    },
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                          ],
                        );
                      } else {
                        return SizedBox();
                      }
                    },
                  ),
                  Text(
                    R.generalInformation.tr(),
                    style: AppStyle.mediumTitleStyleDark,
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16)),
                    child: Column(
                      children: [
                        MenuItem(
                          iconData: Icons.language,
                          content: R.language.tr(),
                          callback: () {
                            NavigationUtil.pushNamed(LanguagePage.route);
                          },
                        ),
                        const Divider(
                          height: 1,
                          indent: 8,
                        ),
                        MenuItem(
                          iconData: Icons.info_outline_rounded,
                          content: R.appPermission.tr(),
                          callback: () {
                            NavigationUtil.pushNamed(NotifyPermissionPage.route,
                                arguments: true);
                          },
                        ),
                        const Divider(
                          height: 1,
                          indent: 8,
                        ),
                        MenuItem(
                          iconData: Icons.chat_outlined,
                          content: R.help.tr(),
                          callback: () {
                            NavigationUtil.pushNamed(ChatBotPage.route);
                          },
                        ),
                        // const Divider(
                        //   height: 1,
                        //   indent: 8,
                        // ),
                        // MenuItem(
                        //   iconData: Icons.email_outlined,
                        //   content: "Report & Support",
                        //   callback: () {},
                        // ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  BlocBuilder<UserBloc, UserState>(
                    builder: (context, state) {
                      if (state is UserLoadSuccess) {
                        return Align(
                            alignment: Alignment.center,
                            child: SizedBox(
                                width: double.infinity,
                                child: ElevatedButton.icon(
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext dialogContext) =>
                                            MyConfirmDialog(
                                              title: R.confirm.tr(),
                                              content: R.sureLogout.tr(),
                                              callbackOK: () {
                                                // context
                                                //     .read<AccountBloc>()
                                                //     .add(LogoutAccount());
                                                context.read<CartBloc>().add(
                                                    CartDeleteInformation());
                                                context
                                                    .read<UserBloc>()
                                                    .add(UserLogout());
                                                context
                                                    .read<MyBottomNavBarCubit>()
                                                    .selectPage(
                                                        HomePage.indexPage);
                                                Navigator.pop(dialogContext);
                                              },
                                              callbackCancel: () {
                                                Navigator.pop(dialogContext);
                                              },
                                              confirmText: R.logout.tr(),
                                            ));
                                  },
                                  icon: const Icon(Icons.logout_rounded),
                                  label: Text(R.logout.tr()),
                                  style: ElevatedButton.styleFrom(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 12, horizontal: 24),
                                      disabledBackgroundColor:
                                          const Color(0xffCACACA),
                                      disabledForegroundColor:
                                          AppColor.lightColor,
                                      textStyle: AppStyle.mediumTextStyleDark,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      )),
                                )));
                      } else {
                        return Align(
                            alignment: Alignment.center,
                            child: SizedBox(
                                width: double.infinity,
                                child: ElevatedButton.icon(
                                  onPressed: () {
                                    NavigationUtil.pushNamed(LoginPage.route,
                                        arguments: DefaultPage.route);
                                  },
                                  icon: const Icon(Icons.login_rounded),
                                  label: Text(R.registerOrLogin.tr()),
                                  style: ElevatedButton.styleFrom(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 12, horizontal: 24),
                                      disabledBackgroundColor:
                                          const Color(0xffCACACA),
                                      disabledForegroundColor:
                                          AppColor.lightColor,
                                      textStyle: AppStyle.mediumTextStyleDark,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      )),
                                )));
                      }
                    },
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class UserAvatar extends StatelessWidget {
  const UserAvatar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        if (state is UserInitial) {
          return Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 200),
                width: 110,
                height: 110,
                decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: CachedNetworkImageProvider(
                          AppPath.imgDefaultAvatar,
                        ))),
              ),
              Text(
                "...",
                style: AppStyle.largeTitleStyleDark.copyWith(height: 2),
              )
            ],
          );
        } else if (state is UserLoadSuccess) {
          if (state.user.avatarUrl == null) {
            return Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 200),
                  width: 110,
                  height: 110,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: CachedNetworkImageProvider(
                            AppPath.imgDefaultAvatar,
                          ))),
                ),
                Text(
                  "${state.user.firstName} ${state.user.lastName}",
                  style: AppStyle.largeTitleStyleDark.copyWith(height: 2),
                )
              ],
            );
          } else {
            return Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 200),
                  width: 110,
                  height: 110,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: CachedNetworkImageProvider(
                            state.user.avatarUrl!,
                          ))),
                ),
                Text(
                  "${state.user.firstName} ${state.user.lastName}",
                  style: AppStyle.largeTitleStyleDark.copyWith(height: 2),
                )
              ],
            );
          }
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
