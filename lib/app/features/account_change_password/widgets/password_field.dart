import 'package:flutter/material.dart';
import 'package:shopfee/app/config/color.dart';

import '../../../config/style.dart';

class PasswordField extends StatefulWidget {
  final String title;
  final Function(String) callback;

  const PasswordField({
    required this.title,
    required this.callback,
  });

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  late bool _passwordVisible;

  @override
  void initState() {
    super.initState();
    _passwordVisible = false;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.title, style: AppStyle.mediumTextStyleDark),
        const SizedBox(
          height: 8,
        ),
        TextFormField(
          onChanged: (value) => {widget.callback(value)},
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: (value) {
            if (value!.isEmpty) {
              return 'Please fill this section';
            }
            // else if (value.length < 6) {
            //   return 'Password must have greater or equal 6 characters';
            // }
            return null;
          },
          style: const TextStyle(fontSize: 14),
          obscureText: _passwordVisible == false,
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
            contentPadding: const EdgeInsets.all(8),
            focusedErrorBorder: AppStyle.outlineInputBorderDefault,
            errorBorder: AppStyle.outlineInputBorderDefault,
            enabledBorder:AppStyle.outlineInputBorderDefault,
            focusedBorder: AppStyle.outlineInputBorderPrimary,
            hintText: widget.title,
          ),
        ),
      ],
    );
  }
}
