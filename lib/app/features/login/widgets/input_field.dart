
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopfee/app/config/style.dart';
import 'package:shopfee/app/features/login/cubit/login_cubit.dart';

class InputField extends StatelessWidget {
  final String title;
  final String hint;
  final String? email;
  final bool isPassword;

  InputField(
      {required this.title, required this.hint, this.email, this.isPassword = false});

  TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: Text(
            title,
            style: AppStyle.normalTextStyle.copyWith(color: Color(0xff3C3C3C)),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        TextFormField(
          enabled: email == null,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: (value) {
            context
                .read<LoginCubit>()
                .addField(title, _controller.text);
            if (value!.isEmpty) {
              return 'Please fill this section';
            }
            return null;
          },
          obscureText: isPassword,
          controller: _controller,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            focusedErrorBorder: AppStyle.outlineInputBorderDefault,
            errorBorder: AppStyle.outlineInputBorderDefault,
            enabledBorder: AppStyle.outlineInputBorderDefault,
            focusedBorder: AppStyle.outlineInputBorderPrimary,
            disabledBorder: AppStyle.outlineInputBorderDefault,
            hintText: email ?? hint,
          ),
        ),
      ],
    );
  }
}
