
import 'package:flutter/material.dart';
import 'package:shopfee/core/common/widgets/my_radio.dart';
import 'package:shopfee/core/config/app_style.dart';

class SortItem<T> extends StatelessWidget {
  final String title;
  final T value;
  final T? groupValue;
  final Function(T?) callback;

  const SortItem({
    Key? key,
    required this.title,
    required this.value,
    required this.groupValue,
    required this.callback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            title,
            style: AppStyle.normalTextStyleDark,
          ),
        ),
        MyRadio(
          value: value,
          groupValue: groupValue,
          onChanged: (T? value) {
            callback(value);
          },
        ),
      ],
    );
  }
}
