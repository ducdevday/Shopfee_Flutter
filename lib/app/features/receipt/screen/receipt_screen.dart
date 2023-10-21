import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shopfee/app/common/widgets/my_error.dart';
import 'package:shopfee/app/common/widgets/my_loading.dart';
import 'package:shopfee/app/config/color.dart';
import 'package:shopfee/app/config/dimens.dart';
import 'package:shopfee/app/config/style.dart';
import 'package:shopfee/app/features/receipt/bloc/receipt_bloc.dart';
import 'package:shopfee/app/features/receipt/widgets/bought_list.dart';
import 'package:shopfee/app/features/receipt/widgets/delivery_information.dart';
import 'package:shopfee/app/features/receipt/widgets/payment_summary.dart';
import 'package:shopfee/app/features/receipt/widgets/receipt_information.dart';
import 'package:shopfee/data/repositories/order/order_repository.dart';

class ReceiptScreen extends StatelessWidget {
  final String orderId;

  const ReceiptScreen({Key? key, required this.orderId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          Navigator.pushNamedAndRemoveUntil(context, "/home", (route) => false);
          return Future.value(false);
        },
        child: Scaffold(
          body: BlocProvider(
            create: (context) =>
            ReceiptBloc(orderRepository: context.read<OrderRepository>())
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
                                  Navigator.pushNamedAndRemoveUntil(
                                      context, "/home", (route) => false);
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

class Review extends StatelessWidget {
  const Review({
    super.key,
    required this.orderId,
  });

  final String orderId;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReceiptBloc, ReceiptState>(
      builder: (context, state) {
        if(state is ReceiptLoaded && state.isSuccess == true){
          return Column(
            children: [
              Container(
                height: 4,
                color: Color(0xffEFEBE9),
              ),
              Container(
                padding: EdgeInsets.all(8),
                height: 70,
                child: Row(
                  children: [
                    Container(
                      height: double.infinity,
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                          const BorderRadius.only(
                              bottomLeft:
                              Radius.circular(8),
                              topLeft:
                              Radius.circular(8)),
                          border: Border.all(
                              color: Color(0xffF0F0F0))),
                      child: Row(
                        children: [
                          Builder(builder: (context) {
                            if (state.receipt.review !=
                                null) {
                              return Text(
                                "${state.receipt.review!.rating}",
                                style: AppStyle
                                    .mediumTextStyleDark,
                              );
                            } else {
                              return SizedBox();
                            }
                          }),
                          Icon(
                            Icons.star_rounded,
                            color: Colors.amber,
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(8),
                        decoration: const BoxDecoration(
                          color: Color(0xffF0F0F0),
                          borderRadius: BorderRadius.only(
                              bottomRight:
                              Radius.circular(8),
                              topRight:
                              Radius.circular(8)),
                        ),
                        child:
                        Builder(builder: (context) {
                          if (state.receipt.review ==
                              null) {
                            return Column(
                              crossAxisAlignment:
                              CrossAxisAlignment
                                  .start,
                              children: [
                                Text(
                                  "You haven't leave a review yet",
                                  style: AppStyle
                                      .mediumTextStyleDark,
                                ),
                                SizedBox(
                                  height: 4,
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context,
                                        "/review",
                                        arguments:
                                        orderId)
                                        .then((value) =>
                                        context
                                            .read<
                                            ReceiptBloc>()
                                            .add(LoadReceipt(
                                            orderId:
                                            orderId)));
                                  },
                                  child: Text(
                                    "Review now",
                                    style: AppStyle
                                        .normalTextStylePrimary,
                                  ),
                                )
                              ],
                            );
                          } else {
                            return Column(
                              crossAxisAlignment:
                              CrossAxisAlignment
                                  .start,
                              children: [
                                Text(
                                  "Thank for your review",
                                  style: AppStyle
                                      .mediumTextStyleDark,
                                ),
                                SizedBox(
                                  height: 4,
                                ),
                                Text(
                                  "\"${state.receipt.review!.content}\"",
                                  style: AppStyle
                                      .normalTextStyleDark,
                                  maxLines: 1,
                                  overflow: TextOverflow
                                      .ellipsis,
                                )
                              ],
                            );
                          }
                        }),
                      ),
                    )
                  ],
                ),
              ),
            ],
          );
        }
        else{
          return SizedBox();
        }
      },
    );
  }
}
