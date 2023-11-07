import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopfee/app/config/color.dart';
import 'package:shopfee/app/config/style.dart';
import 'package:shopfee/app/features/login/cubit/login_cubit.dart';

class InputField extends StatefulWidget {
  final String title;
  final String hint;
  final String? email;
  final bool isPassword;

  InputField(
      {required this.title,
      required this.hint,
      this.email,
      this.isPassword = false});

  @override
  State<InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  TextEditingController _controller = TextEditingController();
  late bool _passwordVisible;

  @override
  void initState() {
    super.initState();
    _passwordVisible = false;
  }

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
          enabled: widget.email == null,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: (value) {
            context.read<LoginCubit>().addField(widget.title, _controller.text);
            if (value!.isEmpty) {
              return 'Please fill this section';
            }
            return null;
          },
          obscureText: widget.isPassword && _passwordVisible == false,
          controller: _controller,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            suffixIcon: widget.isPassword
                ? IconButton(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    icon: Icon(
                      // Based on passwordVisible state choose the icon
                      _passwordVisible
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                      color: AppColor.headingColor,
                      size: 20,
                    ),
                    onPressed: () {
                      setState(() {
                        _passwordVisible = !_passwordVisible;
                      });
                    },
                  )
                : null,
            focusedErrorBorder: AppStyle.outlineInputBorderDefault,
            errorBorder: AppStyle.outlineInputBorderDefault,
            enabledBorder: AppStyle.outlineInputBorderDefault,
            focusedBorder: AppStyle.outlineInputBorderPrimary,
            disabledBorder: AppStyle.outlineInputBorderDefault,
            hintText: widget.email ?? widget.hint,
          ),
        ),
      ],
    );
  }
}
