import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopfee/app/config/color.dart';
import 'package:shopfee/app/config/style.dart';
import 'package:shopfee/app/features/receipt/bloc/receipt_bloc.dart';
import 'package:shopfee/app/utils/string_converter_util.dart';
import 'package:shopfee/data/models/status_order.dart';

class CancelDetail extends StatelessWidget {
  const CancelDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReceiptBloc, ReceiptState>(
      builder: (context, state) {
        if (state is ReceiptLoaded &&
            state.eventLog.orderStatus == OrderStatus.CANCELED) {
          return Column(
            children: [
              Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Canceled Detail",
                        style: AppStyle.mediumTitleStyleDark
                            .copyWith(color: AppColor.headingColor)),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Request by",
                        style: AppStyle.normalTextStyleDark
                            .copyWith(fontWeight: FontWeight.w400),
                      ),
                      Text(
                        state.eventLog.makerByEmployee!
                            ? "Employee"
                            : "Customer",
                        style: AppStyle.normalTextStyleDark
                            .copyWith(fontWeight: FontWeight.w400),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Request at",
                        style: AppStyle.normalTextStyleDark
                            .copyWith(fontWeight: FontWeight.w400),
                      ),
                      Text(
                        "${StringConverterUtil.formattedTime(state.eventLog.time)} - ${StringConverterUtil.formattedDate2(state.eventLog.time)}",
                        style: AppStyle.normalTextStyleDark
                            .copyWith(fontWeight: FontWeight.w400),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Reason",
                        style: AppStyle.normalTextStyleDark
                            .copyWith(fontWeight: FontWeight.w400),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width / 2,
                        child: Text(
                          "${state.eventLog.description}",
                          style: AppStyle.normalTextStyleDark
                              .copyWith(fontWeight: FontWeight.w400),
                          textAlign: TextAlign.right,
                        ),
                      )
                    ],
                  ),
                ],
              ),
              Divider(
                height: 20,
              ),
            ],
          );
        } else {
          return SizedBox();
        }
      },
    );
  }
}
