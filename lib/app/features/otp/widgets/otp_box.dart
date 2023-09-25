
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shopfee/app/config/color.dart';
import 'package:shopfee/app/features/otp/cubit/otp_cubit.dart';

class OtpBox extends StatefulWidget {
  final OtpCubit _cubit;
  final int index;
  final bool isLast;

  const OtpBox(
      {required OtpCubit cubit, required this.index, this.isLast = false})
      : _cubit = cubit;

  @override
  State<OtpBox> createState() => _OtpBoxState();
}

class _OtpBoxState extends State<OtpBox> {
  FocusNode _textFieldFocus = FocusNode();
  Color _color = Color(0xffF0F0F0);
  TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    _textFieldFocus.addListener(() {
      if (_textFieldFocus.hasFocus) {
        setState(() {
          _color = Colors.white;
        });
      } else {
        setState(() {
          _color = Color(0xffF0F0F0);
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 56,
      height: 66,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16), color: Color(0xffF0F0F0)),
      child: TextField(
        onChanged: (value) => {
          widget._cubit.addOTP(_controller.text, widget.index),
          if (widget.isLast == false && _controller.text.isNotEmpty) {FocusScope.of(context).nextFocus()}
        },
        focusNode: _textFieldFocus,
        style: TextStyle(fontSize: 24),
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        inputFormatters: [
          LengthLimitingTextInputFormatter(1),
          FilteringTextInputFormatter.digitsOnly
        ],
        controller: _controller,
        decoration: InputDecoration(
          fillColor: _color,
          filled: true,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.0),
            borderSide: BorderSide.none,
          ),
          border: OutlineInputBorder(
              borderSide: BorderSide(color: AppColor.primaryColor),
              borderRadius: BorderRadius.circular(16)),
        ),
      ),
    );
  }
}
