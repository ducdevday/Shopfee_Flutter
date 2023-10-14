import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class MyError extends StatelessWidget {
  const MyError({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Lottie.asset("assets/images/lottie_coffee_error.json"),
      ),
    );
  }
}
