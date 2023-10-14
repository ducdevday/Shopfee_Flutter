import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shopfee/app/config/style.dart';

class MyConfirmDialog extends StatelessWidget {
  final String title;
  final String content;
  final VoidCallback callbackOK;
  final VoidCallback callbackCancel;

  const MyConfirmDialog(
      {Key? key,
      required this.title,
      required this.content,
      required this.callbackOK,
      required this.callbackCancel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: title.isNotEmpty ? Text(title) : null,
      content: content.isNotEmpty ? Text(content) : null,
      actions: <CupertinoDialogAction>[
        CupertinoDialogAction(
            onPressed: callbackCancel,
            child: Text(
              "Cancel",
              style: AppStyle.normalTextStylePrimary,
            )),
        CupertinoDialogAction(
            onPressed: callbackOK,
            child: Text(
              "Confirm",
              style: AppStyle.normalTextStylePrimary,
            ))
      ],
    );
  }
}
