import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopfee/app/config/color.dart';
import 'package:shopfee/app/config/style.dart';
import 'package:shopfee/app/features/cart/bloc/cart_bloc.dart';
import 'package:shopfee/data/models/type_payment.dart';

class PaymentBottomSheet extends StatefulWidget {
  const PaymentBottomSheet({
    super.key,
  });

  @override
  State<PaymentBottomSheet> createState() => _PaymentBottomSheetState();
}

class _PaymentBottomSheetState extends State<PaymentBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        if (state is CartLoaded) {
          return Wrap(
            // child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Visibility(
                    visible: false,
                    maintainSize: true,
                    maintainAnimation: true,
                    maintainState: true,
                    child: IconButton(
                        onPressed: () {}, icon: Icon(Icons.close_rounded)),
                  ),
                  Text(
                    "Choose Payment Method",
                    style: AppStyle.mediumTitleStyleDark,
                  ),
                  IconButton(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.close_rounded))
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Row(
                  children: [
                    Image.asset(
                      "assets/icons/ic_cash.jpg",
                      width: 24,
                      height: 24,
                    ),
                    SizedBox(
                      width: 4,
                    ),
                    Expanded(child: Text("Cash")),
                    Radio(
                        activeColor: AppColor.primaryColor,
                        value: TypePayment.CASHING,
                        groupValue: state.cart.typePayment,
                        onChanged: (TypePayment? value) {
                          context.read<CartBloc>().add(ChooseTypePayment(value!));
                          Navigator.pop(context);
                        })
                  ],
                ),
              ),
              Divider(
                height: 10,
                indent: 10,
                endIndent: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Row(
                  children: [
                    Image.asset(
                      "assets/icons/ic_vnpay.png",
                      width: 24,
                      height: 24,
                    ),
                    SizedBox(
                      width: 4,
                    ),
                    Expanded(child: Text("VNPAY")),
                    Radio(
                        activeColor: AppColor.primaryColor,
                        value: TypePayment.BANKING,
                        groupValue: state.cart.typePayment,
                        onChanged: (TypePayment? value) {
                          context.read<CartBloc>().add(ChooseTypePayment(value!));
                          Navigator.pop(context);
                        })
                  ],
                ),
              ),
            ],
            // ),
          );
        } else {
          return SizedBox();
        }
      },
    );
  }
}
