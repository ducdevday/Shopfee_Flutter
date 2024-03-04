import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:shopfee/core/config/app_style.dart';

class PhoneInputField extends StatefulWidget {
  final String title;
  final String hint;
  final Function(String input) validateField;
  final bool isEnable;
  final TextEditingController controller;

  const PhoneInputField(
      {super.key, required this.title,
        required this.hint,
        required this.validateField,
        this.isEnable = true,
        required this.controller});

  @override
  State<PhoneInputField> createState() => _PhoneInputFieldState();
}

class _PhoneInputFieldState extends State<PhoneInputField> {
  final FocusNode _focusNode = FocusNode();
  String? errorText;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        setState(() {
          errorText = widget.validateField(widget.controller.text);
        });
      }
    });
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
          keyboardType: TextInputType.phone,
          validator: (value) {
            return widget.validateField(value!);
          },
          textInputAction: TextInputAction.next,
          inputFormatters: [
            PhoneInputFormatter(
              allowEndlessPhone: false,
              defaultCountryCode: "VN",
            )
          ],
          controller: widget.controller,
          focusNode: _focusNode,
          decoration: InputDecoration(
            errorText: errorText,
            contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            focusedErrorBorder: AppStyle.outlineInputBorderDefault,
            errorBorder: AppStyle.outlineInputBorderDefault,
            enabledBorder: AppStyle.outlineInputBorderDefault,
            focusedBorder: AppStyle.outlineInputBorderPrimary,
            disabledBorder: AppStyle.outlineInputBorderDefault,
            hintText: widget.hint,
              hintStyle: TextStyle(color: Colors.grey)
          ),
        ),
      ],
    );
  }
}