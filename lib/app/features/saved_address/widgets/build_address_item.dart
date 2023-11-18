import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shopfee/app/config/color.dart';
import 'package:shopfee/app/config/dimens.dart';
import 'package:shopfee/app/config/routes.dart';
import 'package:shopfee/app/config/style.dart';
import 'package:shopfee/app/features/saved_address/bloc/saved_address_bloc.dart';
import 'package:shopfee/app/features/saved_address/widgets/build_label_default.dart';

Widget buildAddressItem(
    SavedAddressLoaded state, int index, BuildContext context) {
  return Padding(
    padding: const EdgeInsets.only(
        left: 26, right: 16, top: AppDimen.spacing, bottom: AppDimen.spacing),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        state.addressList[index].recipientName!,
                        style: AppStyle.mediumTextStyleDark
                            .copyWith(color: AppColor.headingColor),
                      ),
                      Text(
                        "  |  ",
                        style: AppStyle.normalTextStyleDark,
                      ),
                      Text(
                        state.addressList[index].phoneNumber!,
                        style: AppStyle.normalTextStyleDark,
                      ),
                    ],
                  ),
                  Text(
                    state.addressList[index].details!,
                    style: AppStyle.normalTextStyleDark,
                  ),
                ],
              ),
            ),
            IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, AppRouter.newAddressRoute,
                          arguments: state.addressList[index].id)
                      .then((value) => context
                          .read<SavedAddressBloc>()
                          .add(LoadSavedAddress()));
                },
                icon: SvgPicture.asset(
                  "assets/icons/ic_edit.svg",
                  color: AppColor.primaryColor,
                ))
          ],
        ),
        buildLabelDefault(state.addressList[index].isDefault!)
      ],
    ),
  );
}
