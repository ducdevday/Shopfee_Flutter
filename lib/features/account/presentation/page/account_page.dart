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
                              "Account",
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
                                    content: "Personal Information",
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
                                    content: "Change Password",
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
                                    content: "Saved Address",
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
                              "Activity",
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
                                    content: "History",
                                    callback: () {
                                      NavigationUtil.pushNamed(
                                          HistoryPage.route);
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
                    "General Information",
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
                          iconData: Icons.local_police_outlined,
                          content: "Policies",
                          callback: () {},
                        ),
                        const Divider(
                          height: 1,
                          indent: 8,
                        ),
                        MenuItem(
                          iconData: Icons.info_outline_rounded,
                          content: "App Version",
                          callback: () {},
                        ),
                        const Divider(
                          height: 1,
                          indent: 8,
                        ),
                        MenuItem(
                          iconData: Icons.help_outline_rounded,
                          content: "About us",
                          callback: () {},
                        ),
                        const Divider(
                          height: 1,
                          indent: 8,
                        ),
                        MenuItem(
                          iconData: Icons.email_outlined,
                          content: "Report & Support",
                          callback: () {},
                        ),
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
                            child: Container(
                                width: double.infinity,
                                child: ElevatedButton.icon(
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext dialogContext) =>
                                            MyConfirmDialog(
                                              title: "Confirm",
                                              content:
                                                  "Are you sure to Log out",
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
                                                    .selectPage(HomePage.indexPage);
                                                Navigator.pop(dialogContext);
                                              },
                                              callbackCancel: () {
                                                Navigator.pop(dialogContext);
                                              },
                                              confirmText: "Log out",
                                            ));
                                  },
                                  icon: const Icon(Icons.logout_rounded),
                                  label: const Text("Log out"),
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
                            child: Container(
                                width: double.infinity,
                                child: ElevatedButton.icon(
                                  onPressed: () {
                                    NavigationUtil.pushNamed(LoginPage.route,
                                        arguments: DefaultPage.route);
                                  },
                                  icon: const Icon(Icons.login_rounded),
                                  label: const Text("Register / Log in"),
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
                        image: NetworkImage(
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
                          image: NetworkImage(
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
                          image: NetworkImage(
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
