import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopfee/app/common/widgets/my_alert_dialog.dart';
import 'package:shopfee/app/common/widgets/my_confirm_dialog.dart';
import 'package:shopfee/app/config/color.dart';
import 'package:shopfee/app/config/dimens.dart';
import 'package:shopfee/app/config/routes.dart';
import 'package:shopfee/app/config/style.dart';
import 'package:shopfee/app/features/new_address/bloc/new_address_bloc.dart';
import 'package:shopfee/app/features/new_address/widgets/address_field.dart';
import 'package:shopfee/app/features/new_address/widgets/update_default.dart';
import 'package:shopfee/data/models/place_search.dart';
import 'package:shopfee/data/repositories/address/address_repository.dart';

import '../../../utils/permission_util.dart';

class NewAddressScreen extends StatelessWidget {
  final String? addressId;

  const NewAddressScreen({Key? key, this.addressId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
      NewAddressBloc(addressRepository: context.read<AddressRepository>())
        ..add(LoadNewAddress(addressId: addressId)),
      child: BlocConsumer<NewAddressBloc, NewAddressState>(
        listener: (context, state) {
          if (state is NewAddressFinished) {
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          if (state is NewAddressLoaded) {
            return Scaffold(
              resizeToAvoidBottomInset: false,
              appBar: AppBar(
                title: Text(
                    addressId == null ? "Add New Address" : "Update Address"),
                centerTitle: true,
                bottom: const PreferredSize(
                  preferredSize: Size.fromHeight(1),
                  child: Divider(height: 1),
                ),
                actions: [
                  addressId != null
                      ? IconButton(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onPressed: state.currentDefault == false
                        ? () {
                      showDialog(
                          context: context,
                          builder: (BuildContext contextDialog) =>
                              MyConfirmDialog(
                                  title: "",
                                  content: "Delete this address",
                                  callbackOK: () {
                                    //Để trong này vẫn xóa được phần tử nhưng pop ra màn hình trắng
                                    context
                                        .read<NewAddressBloc>()
                                        .add(DeleteAddress());
                                    Navigator.pop(contextDialog);
                                  },
                                  callbackCancel: () {
                                    Navigator.pop(contextDialog);
                                  }));
                    }
                        : () {
                      showDialog(
                          context: context,
                          builder: (BuildContext dialogContext) =>
                              MyAlertDialog(
                                  title: "",
                                  content:
                                  "To delete this default address, please create another address and set it default",
                                  callback: () {
                                    Navigator.pop(dialogContext);
                                  }));
                    },
                    icon: Icon(
                      Icons.delete_outline_rounded,
                      color: AppColor.primaryColor,
                    ),
                  )
                      : const SizedBox()
                ],
              ),
              body: Container(
                color: const Color(0xffEFEBE9),
                child: Column(
                  children: [
                    const SizedBox(
                      height: AppDimen.spacing,
                    ),
                    Container(
                      color: Colors.white,
                      padding: const EdgeInsets.all(AppDimen.spacing),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              children: [
                                InkWell(
                                  onTap: () async {
                                    if (await PermissionUtil
                                        .requestLocationPermission() ==
                                        true) {
                                      Navigator.pushNamed(context,
                                          AppRouter.geolocationRoute)
                                          .then((value) {
                                            if(value != null) {
                                              context
                                                  .read<NewAddressBloc>()
                                                  .add(AddLocation(
                                                  placeSearch: value
                                                  as PlaceSearch));
                                            };
                                      });
                                    }
                                  },
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Text("Address Name",
                                          style: AppStyle.mediumTextStyleDark),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      TextFormField(
                                        style: const TextStyle(fontSize: 14),
                                        decoration: InputDecoration(
                                          labelText: state.address.details,
                                          labelStyle:
                                          AppStyle.mediumTextStyleDark,
                                          enabled: false,
                                          suffixIcon: const Icon(Icons
                                              .keyboard_arrow_right_rounded),
                                          contentPadding:
                                          const EdgeInsets.all(8),
                                          disabledBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                  color: Color(0xffCCCCCC)),
                                              borderRadius:
                                              BorderRadius.circular(8)),
                                          focusedBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                  color: Color(0xffCCCCCC)),
                                              borderRadius:
                                              BorderRadius.circular(8)),
                                          hintText: "Choose Address",
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 12,
                                ),
                                AddressField(
                                    title: "Address Note",
                                    defaultValue: state.address.note,
                                    callback: (String value) {
                                      context
                                          .read<NewAddressBloc>()
                                          .add(AddNote(note: value));
                                    }),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: AppDimen.spacing,
                    ),
                    Container(
                      padding: const EdgeInsets.all(AppDimen.spacing),
                      color: Colors.white,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              children: [
                                AddressField(
                                    title: "Consignee Name",
                                    defaultValue: state.address.recipientName,
                                    callback: (String value) {
                                      context.read<NewAddressBloc>().add(
                                          AddRecipientName(
                                              recipientName: value));
                                    }),
                                const SizedBox(
                                  height: 12,
                                ),
                                AddressField(
                                    title: "Phone Number",
                                    defaultValue: state.address.phoneNumber,
                                    isPhoneNumber: true,
                                    callback: (String value) {
                                      context.read<NewAddressBloc>().add(
                                          AddPhoneNumber(phoneNumber: value));
                                    }),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: AppDimen.spacing,
                    ),
                    updateDefault(addressId, state.address.isDefault!,
                        state.currentDefault, callback: (bool value) {
                          context
                              .read<NewAddressBloc>()
                              .add(SetDefault(isDefault: value));
                        }, showMyDialog: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext dialogContext) =>
                                  MyAlertDialog(
                                      title: "",
                                      content:
                                      "To cancel this default address, please choose another address to set it default",
                                      callback: () {
                                        Navigator.pop(dialogContext);
                                      }));
                        }),
                    const Spacer(
                      flex: 1,
                    ),
                    Container(
                      width: MediaQuery
                          .of(context)
                          .size
                          .width,
                      padding: const EdgeInsets.all(AppDimen.screenPadding),
                      child: ElevatedButton(
                        onPressed: state.isValid
                            ? () {
                          if (addressId == null) {
                            context
                                .read<NewAddressBloc>()
                                .add(AddNewAddress());
                          } else {
                            context
                                .read<NewAddressBloc>()
                                .add(UpdateAddress());
                          }
                        }
                            : null,
                        child: const Text("Finish"),
                        style: AppStyle.elevatedButtonStylePrimary,
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}
