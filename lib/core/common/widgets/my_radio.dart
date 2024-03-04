import 'package:flutter/material.dart';
import 'package:shopfee/core/config/app_color.dart';

class MyRadio<T> extends StatelessWidget {
  final T value;
  final T? groupValue;
  final ValueChanged<T?>? onChanged;

  const MyRadio({
    Key? key,
    required this.value,
    required this.groupValue,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isSelected = value == groupValue;
    return InkWell(
      onTap: () {
        isSelected = !isSelected;
        if (isSelected) {
          onChanged!(value);
        } else if (!isSelected) {
          onChanged!(null);
        }
      },
      child: Container(
        width: 28,
        height: 28,
        decoration: BoxDecoration(
            color: AppColor.secondaryColor, shape: BoxShape.circle),
        child: isSelected
            ? Icon(
                Icons.check,
                color: AppColor.primaryColor,
                size: 20,
              )
            : null,
      ),
    );
  }
}
