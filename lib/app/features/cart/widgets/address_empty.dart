import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopfee/app/config/routes.dart';
import 'package:shopfee/app/config/style.dart';
import 'package:shopfee/app/features/cart/bloc/cart_bloc.dart';

class AddressEmpty extends StatelessWidget {
  const AddressEmpty({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context,
            AppRouter.newAddressRoute)
            .then((value) => context.read<CartBloc>()
            .add(InitAddress()));
      },
      child: Row(
        children: [
          Expanded(
            child: Text(
              "Please create an address",
              style: AppStyle.normalTextStylePrimary,
            ),
          ),
          const SizedBox(
            width: 40,
          ),
          const Icon(
              Icons.keyboard_arrow_right_rounded),
        ],
      ),
    );
  }
}