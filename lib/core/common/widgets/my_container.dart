import 'package:flutter/material.dart';
import 'package:shopfee/core/config/app_dimen.dart';

class MyContainer extends StatelessWidget {
  final double? padding;
  final double? radius;
  final Widget child;

  const MyContainer({Key? key, this.padding, this.radius, required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(padding ?? AppDimen.spacing),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(radius ?? AppDimen.smallRadius),
          )),
      child: child,
    );
  }
}
