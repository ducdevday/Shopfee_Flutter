import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopfee/app/common/widgets/my_bottom_navigationbar.dart';
import 'package:shopfee/app/config/color.dart';
import 'package:shopfee/app/config/dimens.dart';
import 'package:shopfee/app/config/style.dart';
import 'package:shopfee/app/features/account/bloc/account_bloc.dart';
import 'package:shopfee/data/repositories/user/user_repository.dart';

class AccountScreen extends StatelessWidget {
  final MyBottomNavigationBar myBottomNavigationBar;

  const AccountScreen(this.myBottomNavigationBar, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AccountBloc, AccountState>(
      builder: (context, state) {
        if (state is AccountLoaded) {
          return Scaffold(
            extendBodyBehindAppBar: true,
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Stack(
                    children: [
                      Image.asset("assets/images/img_profile_background.png"),
                      Align(
                        alignment: Alignment.center,
                        child: Column(
                          children: [
                            Container(
                              margin: EdgeInsets.only(top: 200),
                              width: 110,
                              height: 110,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: AssetImage(
                                        "assets/images/img_default_user.png",
                                      ))),
                            ),
                            Text(
                              "${state.user.lastName} ${state.user.firstName}",
                              style: AppStyle.largeTitleStyleDark
                                  .copyWith(height: 2),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.all(AppDimen.screenPadding),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Account",
                          style: AppStyle.mediumTitleStyleDark,
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16)),
                          child: Column(
                            children: [
                              SettingItem(
                                iconData: Icons.account_circle_outlined,
                                content: "Personal Information",
                                callback: () {
                                  Navigator.pushNamed(
                                      context, "/personal_information",
                                      arguments: state.user);
                                },
                              ),
                              Divider(
                                height: 1,
                                indent: 8,
                              ),
                              SettingItem(
                                iconData: Icons.vpn_key_outlined,
                                content: "Change Password",
                                callback: () {},
                              ),
                              Divider(
                                height: 1,
                                indent: 8,
                              ),
                              SettingItem(
                                iconData: Icons.bookmark_border_rounded,
                                content: "Saved Address",
                                callback: () {
                                  Navigator.pushNamed(context, "/saved_address");
                                },
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Text(
                          "General Information",
                          style: AppStyle.mediumTitleStyleDark,
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16)),
                          child: Column(
                            children: [
                              SettingItem(
                                iconData: Icons.local_police_outlined,
                                content: "Policies",
                                callback: () {},
                              ),
                              Divider(
                                height: 1,
                                indent: 8,
                              ),
                              SettingItem(
                                iconData: Icons.info_outline_rounded,
                                content: "App Version",
                                callback: () {},
                              ),
                              Divider(
                                height: 1,
                                indent: 8,
                              ),
                              SettingItem(
                                iconData: Icons.help_outline_rounded,
                                content: "About us",
                                callback: () {},
                              ),
                              Divider(
                                height: 1,
                                indent: 8,
                              ),
                              SettingItem(
                                iconData: Icons.email_outlined,
                                content: "Report & Support",
                                callback: () {},
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        Align(
                            alignment: Alignment.center,
                            child: Container(
                                width: double.infinity,
                                child: ElevatedButton.icon(
                                  onPressed: () {},
                                  icon: Icon(Icons.logout_rounded),
                                  label: Text("Log out"),
                                  style: ElevatedButton.styleFrom(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 12, horizontal: 24),
                                      disabledBackgroundColor:
                                          const Color(0xffCACACA),
                                      disabledForegroundColor:
                                          AppColor.lightColor,
                                      textStyle: AppStyle.mediumTextStyleDark,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      )),
                                )))
                      ],
                    ),
                  )
                ],
              ),
            ),
            bottomNavigationBar: myBottomNavigationBar,
          );
        } else {
          return SizedBox();
        }
      },
    );
  }
}

class SettingItem extends StatelessWidget {
  final IconData iconData;
  final String content;
  final VoidCallback callback;

  const SettingItem({
    super.key,
    required this.iconData,
    required this.content,
    required this.callback,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: callback,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8.0),
        child: Row(
          children: [
            Icon(iconData),
            SizedBox(
              width: 8,
            ),
            Expanded(
                child: Text(
              content,
              style: AppStyle.mediumTextStyleDark,
            )),
            Icon(Icons.keyboard_arrow_right_rounded)
          ],
        ),
      ),
    );
  }
}
