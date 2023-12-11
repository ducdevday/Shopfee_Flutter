import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shopfee/app/common/widgets/my_error.dart';
import 'package:shopfee/app/common/widgets/my_loading.dart';
import 'package:shopfee/app/config/color.dart';
import 'package:shopfee/app/config/dimens.dart';
import 'package:shopfee/app/config/routes.dart';
import 'package:shopfee/app/config/style.dart';
import 'package:shopfee/app/features/receipt/bloc/receipt_bloc.dart';
import 'package:shopfee/app/features/receipt/widgets/bought_list.dart';
import 'package:shopfee/app/features/receipt/widgets/delivery_information.dart';
import 'package:shopfee/app/features/receipt/widgets/note_receipt.dart';
import 'package:shopfee/app/features/receipt/widgets/payment_summary.dart';
import 'package:shopfee/app/features/receipt/widgets/receipt_information.dart';
import 'package:shopfee/app/features/receipt/widgets/review.dart';
import 'package:shopfee/data/models/status_order.dart';
import 'package:shopfee/data/repositories/firebase/firebase_repository.dart';
import 'package:shopfee/data/repositories/order/order_repository.dart';

class ReceiptScreen extends StatelessWidget {
  final String orderId;

  const ReceiptScreen({Key? key, required this.orderId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          Navigator.pushNamedAndRemoveUntil(context, AppRouter.homeRoute, (route) => false);
          return Future.value(false);
        },
        child: Scaffold(
          body: BlocProvider(
            create: (context) => ReceiptBloc(
                orderRepository: context.read<OrderRepository>(),
                firebaseRepository: context.read<FirebaseRepository>())
              ..add(LoadReceipt(orderId: orderId)),
            child: BlocBuilder<ReceiptBloc, ReceiptState>(
              builder: (context, state) {
                if (state is ReceiptLoading) {
                  return MyLoading();
                } else if (state is ReceiptLoaded) {
                  return SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: AppDimen.screenPadding,
                          right: AppDimen.screenPadding,
                          bottom: AppDimen.screenPadding),
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: AppDimen.screenPadding * 2,
                                  bottom: AppDimen.screenPadding),
                              child: InkWell(
                                splashColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () {
                                  Navigator.pushNamedAndRemoveUntil(context, AppRouter.homeRoute, (route) => false);
                                },
                                child: Icon(Icons.close_rounded),
                              ),
                            ),
                          ),
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
                                    Review(orderId: orderId),
                                    Container(
                                      height: 4,
                                      color: Color(0xffEFEBE9),
                                    ),
                                    DeliveryInformation(),
                                    Container(
                                      height: 4,
                                      color: Color(0xffEFEBE9),
                                    ),
                                    ItemList(),
                                    Container(
                                      height: 4,
                                      color: Color(0xffEFEBE9),
                                    ),
                                    PaymentSummary(),
                                    NoteReceipt(),
                                  ],
                                ),
                              ),
                              Builder(builder: (context) {
                                if (state.eventLog.orderStatus !=
                                    OrderStatus.CANCELED) {
                                  return Center(
                                      child: SvgPicture.asset(
                                          "assets/icons/ic_success.svg"));
                                } else {
                                  return Center(
                                      child: SvgPicture.asset(
                                          "assets/icons/ic_cancel.svg"));
                                }
                              }),
                            ],
                          ),
                          // SizedBox(height: 20),
                          // ElevatedButton(
                          //     onPressed: () {
                          //       Navigator.pushNamed(context, "/review",
                          //           arguments: orderId);
                          //     },
                          //     child: Text(
                          //       "Review",
                          //     ),
                          //     style: ElevatedButton.styleFrom(
                          //         backgroundColor:
                          //             AppColor.primaryColorBackground,
                          //         foregroundColor: AppColor.primaryColor,
                          //         disabledBackgroundColor:
                          //             const Color(0xffCACACA),
                          //         disabledForegroundColor: AppColor.lightColor,
                          //         shape: RoundedRectangleBorder(
                          //             borderRadius: BorderRadius.circular(16))))
                        ],
                      ),
                    ),
                  );
                } else {
                  return MyError();
                }
              },
            ),
          ),
        ));
  }
}

