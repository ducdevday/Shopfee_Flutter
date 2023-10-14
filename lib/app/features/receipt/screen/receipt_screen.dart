import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shopfee/app/common/widgets/my_error.dart';
import 'package:shopfee/app/common/widgets/my_loading.dart';
import 'package:shopfee/app/config/dimens.dart';
import 'package:shopfee/app/config/style.dart';
import 'package:shopfee/app/features/receipt/cubit/receipt_cubit.dart';
import 'package:shopfee/app/features/receipt/widgets/bought_list.dart';
import 'package:shopfee/app/features/receipt/widgets/payment_summary.dart';
import 'package:shopfee/app/features/receipt/widgets/receipt_information.dart';

class ReceiptScreen extends StatelessWidget {
  const ReceiptScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushNamedAndRemoveUntil(context, "/home", (route) => false);
        return Future.value(false);
      },
      child: BlocProvider(
        create: (context) => ReceiptCubit()..initCheckout(),
        child: BlocBuilder<ReceiptCubit, ReceiptState>(
          builder: (context, state) {
            switch (state.runtimeType) {
              case ReceiptLoading:
                return MyLoading();
              case ReceiptLoaded:
                return Scaffold(
                  appBar: AppBar(
                    automaticallyImplyLeading: false,
                    leading: InkWell(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () {
                        Navigator.pushNamedAndRemoveUntil(
                            context, "/home", (route) => false);
                      },
                      child: Icon(Icons.arrow_back),
                    ),
                    title: Text("Receipt"),
                    centerTitle: true,
                  ),
                  body: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: AppDimen.screenPadding,
                          right: AppDimen.screenPadding,
                          bottom: AppDimen.screenPadding),
                      child: Column(
                        children: [
                          Stack(
                            children: [
                              Container(
                                margin: EdgeInsets.only(top: 40),
                                decoration: BoxDecoration(
                                    border:
                                        Border.all(color: Color(0xffefebe9)),
                                    borderRadius: BorderRadius.circular(16)),
                                child: Column(
                                  children: [
                                    ReceiptInformation(),
                                    Container(
                                      height: 4,
                                      color: Color(0xffEFEBE9),
                                    ),
                                    BoughtList(),
                                    Container(
                                      height: 4,
                                      color: Color(0xffEFEBE9),
                                    ),
                                    PaymentSummary(),
                                  ],
                                ),
                              ),
                              Center(
                                  child: SvgPicture.asset(
                                      "assets/icons/ic_success.svg")),
                            ],
                          ),
                          SizedBox(height: 20),
                          ElevatedButton(
                              onPressed: () {},
                              child: Text(
                                "Tracking Order",
                              ),
                              style: AppStyle.elevatedButtonStylePrimary)
                        ],
                      ),
                    ),
                  ),
                );
              default:
                return MyError();
            }
          },
        ),
      ),
    );
  }
}
