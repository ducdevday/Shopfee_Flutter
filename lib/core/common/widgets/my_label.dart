import 'package:flutter/material.dart';

class MyLabel extends StatelessWidget {
  final String label;
  final Color color;

  const MyLabel({Key? key, required this.label, required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
        onPressed: null,
        child: Text(label),
        style: OutlinedButton.styleFrom(
            padding: EdgeInsets.zero,
            minimumSize: const Size(84, 26),
            disabledForegroundColor: color,
            side: BorderSide(width: 1, color: color)));
  }
}
