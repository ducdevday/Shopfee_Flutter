import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:shopfee/core/common/enum/field_type.dart';
import 'package:shopfee/core/config/app_color.dart';
import 'package:shopfee/core/config/app_dimen.dart';
import 'package:shopfee/core/config/app_style.dart';
import 'package:shopfee/core/utils/format_util.dart';
import 'package:shopfee/core/utils/validate_field_util.dart';

class MyPhoneInputDialog extends StatefulWidget {
  final String title;
  final String content;
  final Function(String) callbackOK;
  final VoidCallback callbackCancel;
  final String? placeHolderText;
  final String? cancelText;
  final String? confirmText;

  const MyPhoneInputDialog(
      {Key? key,
      required this.title,
      required this.content,
      required this.callbackOK,
      required this.callbackCancel,
      this.placeHolderText,
      this.cancelText,
      this.confirmText})
      : super(key: key);

  @override
  State<MyPhoneInputDialog> createState() => _MyPhoneInputDialogState();
}

class _MyPhoneInputDialogState extends State<MyPhoneInputDialog> {
  late TextEditingController phoneNumberTextController;
  final FocusNode _focusNode = FocusNode();
  String? errorText;

  String? getErrorText(
    String text,
  ) {
    if (!ValidateFieldUtil.validatePhone(text)) {
      return "*Phone number is not valid";
    }
    return null;
  }

  bool checkValidField() {
    if (ValidateFieldUtil.validatePhone(
        phoneNumberTextController.text.trim())) {
      return true;
    } else {
      return false;
    }
  }

  @override
  void initState() {
    super.initState();
    phoneNumberTextController = TextEditingController();
    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        setState(() {
          errorText = getErrorText(phoneNumberTextController.text);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      actions: <CupertinoDialogAction>[
        CupertinoDialogAction(
            onPressed: widget.callbackCancel,
            child: Text(
              widget.cancelText ?? "Cancel",
              style: AppStyle.normalTextStylePrimary
                  .copyWith(color: AppColor.primaryColor),
            )),
        CupertinoDialogAction(
            onPressed: checkValidField()
                ? () {
                    widget.callbackOK(FormatUtil.formatOriginalPhone(
                        phoneNumberTextController.text));
                  }
                : null,
            child: Text(
              widget.confirmText ?? "Confirm",
              style: AppStyle.normalTextStylePrimary
                  .copyWith(color: AppColor.primaryColor),
            ))
      ],
      title: Text(widget.title),
      content: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(widget.content),
          SizedBox(
            height: AppDimen.spacing,
          ),
          CupertinoTextField(
            controller: phoneNumberTextController,
            placeholder: "Enter Phone Number",
            keyboardType: TextInputType.phone,
            focusNode: _focusNode,
            inputFormatters: [
              PhoneInputFormatter(
                allowEndlessPhone: false,
                defaultCountryCode: "VN",
              )
            ],
          ),
          if (errorText != null)
            Column(
              children: [
                SizedBox(height: 4,),
                Text("$errorText",
                    style: AppStyle.mediumTextStyleDark.copyWith(
                      color: AppColor.error,
                    )),
              ],
            )
        ],
      ),
    );
  }
}
