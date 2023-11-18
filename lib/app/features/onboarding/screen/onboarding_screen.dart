import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopfee/app/config/color.dart';
import 'package:shopfee/app/config/dimens.dart';
import 'package:shopfee/app/config/routes.dart';
import 'package:shopfee/app/config/style.dart';
import 'package:shopfee/data/models/onboarding_model.dart';

class OnBoardingScreen extends StatefulWidget {
  List<Onboarding> contents = [
    Onboarding(
        title: 'Choose and customize your Drinks',
        image: 'assets/images/onboarding_one.svg',
        discription:
            "Customize your own drink exactly how you like it by adding any topping you like!!!"),
    Onboarding(
        title: 'Quickly and easily',
        image: 'assets/images/onboarding_two.svg',
        discription:
            "You can place your order quickly and easily without wasting time. You can also schedule orders via your smartphone."),
    Onboarding(
        title: 'Get and Redeem Voucher',
        image: 'assets/images/onboarding_three.svg',
        discription:
            "Exciting prizes await you! Redeem yours by collecting all the points after purchase in the app!"),
  ];

  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  int currentIndex = 0;
  late PageController _controller;

  @override
  void initState() {
    _controller = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _controller,
              itemCount: widget.contents.length,
              onPageChanged: (int index) {
                setState(() {
                  currentIndex = index;
                });
              },
              itemBuilder: (_, i) {
                return Padding(
                  padding: const EdgeInsets.all(AppDimen.screenPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 100,
                      ),
                      SvgPicture.asset(
                        widget.contents[i].image,
                        height: 270,
                        width: 270,
                      ),
                      Text(
                        widget.contents[i].title,
                        style: AppStyle.largeTitleStyleDark,
                      ),
                      const SizedBox(height: 20),
                      Text(
                        widget.contents[i].discription,
                        style: AppStyle.mediumTextStyleDark,
                      )
                    ],
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(32),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      widget.contents.length,
                      (index) => buildDot(index, context),
                    ),
                  ),
                ),
                Container(
                  height: 48,
                  width: 156,
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: ElevatedButton.icon(
                        icon: const Icon(Icons.arrow_back_outlined),
                        label: Text(
                          currentIndex == widget.contents.length - 1
                              ? "START"
                              : "NEXT",
                          style: AppStyle.normalTextStyle,
                        ),
                        onPressed: () {
                          if (currentIndex == widget.contents.length - 1) {
                            Navigator.pushReplacementNamed(context,AppRouter.notifyPermissionRoute);
                          }
                          _controller.nextPage(
                            duration: const Duration(milliseconds: 100),
                            curve: Curves.bounceIn,
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        )),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Container buildDot(int index, BuildContext context) {
    return Container(
      height: 10,
      width: currentIndex == index ? 25 : 10,
      margin: const EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: currentIndex == index
            ? AppColor.primaryColor
            : AppColor.disableColor,
      ),
    );
  }
}
