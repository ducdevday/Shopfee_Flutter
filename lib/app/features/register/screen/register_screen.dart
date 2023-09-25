import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shopfee/app/config/color.dart';
import 'package:shopfee/app/config/dimens.dart';
import 'package:shopfee/app/config/style.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        padding: EdgeInsets.all(AppDimen.screenPadding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                SizedBox(
                  height: 75,
                ),
                SvgPicture.asset(
                  "assets/images/onboarding_one.svg",
                  width: 219.5,
                  height: 100,
                ),
                SizedBox(
                  height: 28,
                ),
                MyInputField(
                    title: "Name", hint: "Input Your Name", controller: _name),
                SizedBox(
                  height: AppDimen.spacing,
                ),
                MyInputField(
                    title: "Email",
                    hint: "Input Your Email",
                    controller: _email),
                SizedBox(
                  height: AppDimen.spacing,
                ),
                MyInputField(
                  title: "Password",
                  hint: "Input Your Password",
                  controller: _password,
                  isPassword: true,
                ),
              ],
            ),
            Column(
              children: [
                Text(
                  "By tapping \"Register\" you agree to our",
                  style: AppStyle.normalTextStyleDark,
                ),
                SizedBox(
                  height: 4,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                        style: TextButton.styleFrom(
                          minimumSize: Size.zero,
                          padding: EdgeInsets.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        onPressed: () {},
                        child: Text(
                          "Terms of Use",
                          style: AppStyle.normalTextStyleDark
                              .copyWith(color: Color(0xff032172)),
                        )),
                    TextButton(
                        style: TextButton.styleFrom(
                          minimumSize: Size.zero,
                          padding: EdgeInsets.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        onPressed: () {},
                        child: Text(
                          " and ",
                          style: AppStyle.normalTextStyleDark,
                        )),
                    TextButton(
                        style: TextButton.styleFrom(
                          minimumSize: Size.zero,
                          padding: EdgeInsets.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        onPressed: () {},
                        child: Text(
                          "Privacy Policy",
                          style: AppStyle.normalTextStyleDark
                              .copyWith(color: Color(0xff032172)),
                        ))
                  ],
                ),
                SizedBox(
                  height: 14,
                ),
                Container(
                  height: 48,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed:_name.text.isNotEmpty && _email.text.isNotEmpty && _password.text.isNotEmpty  ? (){} : null,
                    child: Text("Register"),
                    style: ElevatedButton.styleFrom(
                        disabledBackgroundColor: Color(0xffCACACA),
                        disabledForegroundColor: AppColor.lightColor,
                        textStyle: AppStyle.mediumTextStyleDark,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        )),
                  ),
                ),
                SizedBox(
                  height: 14,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                        style: TextButton.styleFrom(
                          minimumSize: Size.zero,
                          padding: EdgeInsets.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        onPressed: () {},
                        child: Text(
                          "Have an account? ",
                          style: AppStyle.normalTextStyleDark,
                        )),
                    TextButton(
                        style: TextButton.styleFrom(
                          minimumSize: Size.zero,
                          padding: EdgeInsets.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        onPressed: () {},
                        child: Text(
                          "Login",
                          style: AppStyle.normalTextStylePrimary,
                        ))
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}


class MyInputField extends StatefulWidget {
  final String title;
  final String hint;
  final TextEditingController controller;
  final bool isPassword;

  const MyInputField(
      {required this.title,
      required this.hint,
      required this.controller,
      this.isPassword = false});

  @override
  State<MyInputField> createState() => _MyInputFieldState();
}

class _MyInputFieldState extends State<MyInputField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: Text(
            widget.title,
            style: AppStyle.normalTextStyle.copyWith(color: Color(0xff3C3C3C)),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        TextFormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: (value) {
            if (value!.isEmpty) {
              return 'Please fill this section';
            }
            return null;
          },
          obscureText: widget.isPassword,
          controller: widget.controller,
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
            hintText: widget.hint,
          ),
        ),
      ],
    );
  }
}

