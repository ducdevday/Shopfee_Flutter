import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class MyError extends StatelessWidget {
  const MyError({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              children: [
                Lottie.asset("assets/images/lottie_coffee_error.json", width: 200, height: 200),
              ],
            ),
          ],
        ),
      ),
    );
  }

}
