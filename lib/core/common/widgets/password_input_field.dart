import 'package:flutter/material.dart';
import 'package:shopfee/core/config/app_color.dart';
import 'package:shopfee/core/config/app_style.dart';

class PasswordInputField extends StatefulWidget {
  final String title;
  final String hint;
  final Function(String input) validateField;
  final bool isEnable;
  final bool useFocus;
  final TextEditingController controller;

  const PasswordInputField({
    super.key,
    required this.title,
    required this.hint,
    required this.validateField,
    this.isEnable = true,
    this.useFocus = true,
    required this.controller,
  });

  @override
  State<PasswordInputField> createState() => _PasswordInputFieldState();
}

class _PasswordInputFieldState extends State<PasswordInputField> {
  final FocusNode _focusNode = FocusNode();
  String? errorText;
  late bool _passwordVisible;

  @override
  void initState() {
    super.initState();
    _passwordVisible = false;
    if (widget.useFocus) {
      _focusNode.addListener(() {
        if (!_focusNode.hasFocus) {
          setState(() {
            errorText = widget.validateField(widget.controller.text);
          });
        }
      });
    }
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
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
          enabled: widget.isEnable,
          validator: (value) {
            return widget.validateField(value!);
          },
          textInputAction: TextInputAction.next,
          obscuringCharacter: '*',
          obscureText: _passwordVisible == false,
          controller: widget.controller,
          focusNode: _focusNode,
          decoration: InputDecoration(
              suffixIcon: IconButton(
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
              ),
              contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              focusedErrorBorder: AppStyle.outlineInputBorderDefault,
              errorBorder: AppStyle.outlineInputBorderDefault,
              enabledBorder: AppStyle.outlineInputBorderDefault,
              focusedBorder: AppStyle.outlineInputBorderPrimary,
              disabledBorder: AppStyle.outlineInputBorderDefault,
              hintText: widget.hint,
              hintStyle: TextStyle(color: Colors.grey)),
        ),
      ],
    );
  }
}
