import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shopfee/app/common/widgets/my_alert_dialog.dart';
import 'package:shopfee/app/config/color.dart';
import 'package:shopfee/app/config/dimens.dart';
import 'package:shopfee/app/config/routes.dart';
import 'package:shopfee/app/config/style.dart';
import 'package:shopfee/app/features/saved_address/bloc/saved_address_bloc.dart';
import 'package:shopfee/app/features/saved_address/widgets/build_address_item.dart';
import 'package:shopfee/app/utils/permission_util.dart';
import 'package:shopfee/data/repositories/address/address_repository.dart';

class SavedAddressScreen extends StatefulWidget {
  final bool? isFromCart;

  const SavedAddressScreen({Key? key, this.isFromCart}) : super(key: key);

  @override
  State<SavedAddressScreen> createState() => _SavedAddressScreenState();
}

class _SavedAddressScreenState extends State<SavedAddressScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xffEFEBE9),
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
              widget.isFromCart == null ? "Saved Address" : "Choose Address"),
          centerTitle: true,
          bottom: const PreferredSize(
            preferredSize: Size.fromHeight(1),
            child: Divider(height: 1),
          ),
        ),
        body: SingleChildScrollView(
          child: BlocProvider(
            create: (context) => SavedAddressBloc(
                addressRepository: context.read<AddressRepository>())
              ..add(LoadSavedAddress()),
            child: BlocBuilder<SavedAddressBloc, SavedAddressState>(
              builder: (context, state) {
                if (state is SavedAddressLoading) {
                  return SizedBox();
                } else if (state is SavedAddressLoaded) {
                  return Column(
                    children: [
                      SizedBox(
                        height: AppDimen.spacing,
                      ),
                      Container(
                        color: Colors.white,
                        child: Column(
                          children: [
                            ListView.separated(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  if (widget.isFromCart != null) {
                                    if (widget.isFromCart == true) {
                                      return InkWell(
                                        onTap: () {
                                          Navigator.pop(context,
                                              state.addressList[index].id);
                                        },
                                        child: buildAddressItem(
                                            state, index, context),
                                      );
                                    }
                                  }
                                  return buildAddressItem(
                                      state, index, context);
                                },
                                separatorBuilder: (context, index) => Divider(
                                      height: 2,
                                      indent: 20,
                                    ),
                                itemCount: state.addressList.length),
                            Divider(
                              height: 1,
                            ),
                            TextButton.icon(
                                onPressed: () {
                                  checkAddNewAddress(state, context);
                                },
                                icon: Icon(Icons.add_circle_outline),
                                label: Text(
                                  "Add New Address",
                                  style: AppStyle.normalTextStylePrimary,
                                )),
                          ],
                        ),
                      )
                    ],
                  );
                } else {
                  return SizedBox();
                }
              },
            ),
          ),
        ));
  }
}

void checkAddNewAddress(SavedAddressLoaded state, BuildContext context) async {
  if (state.addressList.length < 5) {
    Navigator.pushNamed(context, AppRouter.newAddressRoute).then(
        (value) => context.read<SavedAddressBloc>().add(LoadSavedAddress()));
  } else {
    showDialog(
        context: context,
        builder: (_) => MyAlertDialog(
            title: "",
            content: "You can only save less than or equal 5 address",
            callback: () {
              Navigator.pop(context);
            }));
  }
}
