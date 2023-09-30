import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class MyLoading extends StatelessWidget {
  const MyLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Center(
        child: Column(
          children: [
            Lottie.asset("assets/images/lottie_coffee_pro.json"),
          ],
        ),
      ),
    );
  }
}
