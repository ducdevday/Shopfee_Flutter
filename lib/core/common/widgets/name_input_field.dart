import 'package:flutter/material.dart';
import 'package:shopfee/core/config/app_style.dart';

class NameInputField extends StatefulWidget {
  final String title;
  final String hint;
  final Function(String input) validateField;
  final bool isEnable;
  final TextEditingController controller;

  const NameInputField(
      {super.key,
      required this.title,
      required this.hint,
      required this.validateField,
      this.isEnable = true,
      required this.controller});

  @override
  State<NameInputField> createState() => _NameInputFieldState();
}

class _NameInputFieldState extends State<NameInputField> {
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
            style: AppStyle.normalTextStyle
                .copyWith(color: const Color(0xff3C3C3C)),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        TextFormField(
          enabled: widget.isEnable,
          validator: (value) {
            return widget.validateField(value!);
          },
          textInputAction: TextInputAction.next,
          controller: widget.controller,
          focusNode: _focusNode,
          decoration: InputDecoration(
              errorText: errorText,
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
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
