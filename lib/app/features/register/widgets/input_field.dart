
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopfee/app/config/style.dart';
import 'package:shopfee/app/features/register/cubit/register_cubit.dart';

class InputField extends StatefulWidget {
  final String title;
  final String hint;
  final bool isPassword;

  const InputField(
      {required this.title, required this.hint, this.isPassword = false});

  @override
  State<InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  TextEditingController _controller = TextEditingController();

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
            context.read<RegisterCubit>()
                .addField(widget.title, _controller.text);
            if (value!.isEmpty) {
              return 'Please fill this section';
            }
            return null;
          },
          obscureText: widget.isPassword,
          controller: _controller,
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
            hintText: widget.hint,
          ),
        ),
      ],
    );
  }
}
