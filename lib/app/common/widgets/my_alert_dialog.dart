import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shopfee/app/config/style.dart';

class MyAlertDialog extends StatelessWidget {
  final String title;
  final String content;
  final VoidCallback callback;

  const MyAlertDialog(
      {Key? key,
      required this.title,
      required this.content,
      required this.callback})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: title.isNotEmpty ? Text(title) : null,
      content:content.isNotEmpty? Text(content) : null,
      actions: [TextButton(onPressed: callback, child: Text("OK", style:AppStyle.normalTextStylePrimary.copyWith(fontWeight: FontWeight.w500),))],
    );
  }
}
