import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:shopfee/app/features/checkout/cubit/checkout_cubit.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CheckoutCubit()..initCheckout(),
      child: BlocBuilder<CheckoutCubit, CheckoutState>(
        builder: (context, state) {
          switch (state.runtimeType) {
            case CheckoutLoading:
              return Scaffold(
                body: Center(
                  child: Lottie.asset("assets/images/lottie_coffee_pro.json"),
                ),
              );

            case CheckoutLoaded:
              return Scaffold(
                appBar: AppBar(title: Text("Rec"),) ,
              )
            default:
              return Scaffold(
                body: Center(
                  child: Lottie.asset("assets/images/lottie_coffee_error.json"),
                ),
              );
          }
        },
      ),
    );
  }
}
