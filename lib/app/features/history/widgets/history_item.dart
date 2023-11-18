import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shopfee/app/config/color.dart';
import 'package:shopfee/app/config/dimens.dart';
import 'package:shopfee/app/config/style.dart';
import 'package:shopfee/app/features/history/bloc/history_bloc.dart';
import 'package:shopfee/app/utils/string_converter_util.dart';
import 'package:shopfee/data/models/order_type.dart';
import 'package:shopfee/data/models/status_order.dart';

class HistoryItem extends StatelessWidget {
  final int index;

  const HistoryItem({
    super.key,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HistoryBloc, HistoryState>(
      builder: (context, state) {
        if (state is HistoryLoaded) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: AppDimen.screenPadding),
                child: Row(children: [
                  Builder(builder: (context) {
                    if (state.orderHistoryList[index].orderType ==
                        OrderType.SHIPPING) {
                      return SvgPicture.asset(
                        "assets/icons/ic_delivery.svg",
                        width: 70,
                        height: 70,
                      );
                    } else {
                      return SvgPicture.asset(
                        "assets/icons/ic_take_away.svg",
                        width: 70,
                        height: 70,
                      );
                    }
                  }),
                  const SizedBox(
                    width: 4,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                state.orderHistoryList[index].productName,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: AppStyle.mediumTextStyleDark.copyWith(
                                  color: AppColor.headingColor,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Builder(builder: (context) {
                              if (state.orderHistoryList[index]
                                  .statusLastEvent ==
                                  OrderStatus.SUCCEED) {
                                return Text(
                                    state.orderHistoryList[index]
                                        .statusLastEvent.name,
                                    style: AppStyle.mediumTextStyleDark
                                        .copyWith(color: AppColor.success));
                              } else if (state.orderHistoryList[index]
                                  .statusLastEvent ==
                                  OrderStatus.CANCELED) {
                                return Text(
                                    state.orderHistoryList[index]
                                        .statusLastEvent.name,
                                    style: AppStyle.mediumTextStyleDark
                                        .copyWith(color: AppColor.error));
                              }
                              return Text(
                                state.orderHistoryList[index].statusLastEvent
                                    .name,
                                style: AppStyle.mediumTextStyleDark
                                    .copyWith(color: AppColor.primaryColor),
                              );
                            }),
                          ],
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Text(
                          "${StringConverterUtil.formattedTime(state.orderHistoryList[index].timeLastEvent)} - ${StringConverterUtil.formattedDate(state.orderHistoryList[index].timeLastEvent)}",
                          style: AppStyle.normalTextStyleDark,
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Text(
                          "Total: ${state.orderHistoryList[index].totalPriceString}",
                          style: AppStyle.mediumTextStyleDark.copyWith(
                            color: AppColor.headingColor.withOpacity(0.95),
                          ),
                        ),
                      ],
                    ),
                  ),
                ]),
              ),
              Builder(builder: (context) {
                if (state.orderHistoryList[index].productQuantity > 1) {
                  if (index == state.orderHistoryList.length - 1) {
                    return Column(
                      children: [
                        const Divider(
                          height: 10,
                          indent: AppDimen.screenPadding,
                        ),
                        Text(
                          state.orderHistoryList[index].showMoreString,
                          style: AppStyle.smallTextStyleDark,
                        ),
                        const Divider(
                          height: 10,
                          thickness: 1,
                        ),
                      ],
                    );
                  } else {
                    return Column(
                      children: [
                        const Divider(
                          height: 10,
                          indent: AppDimen.screenPadding,
                        ),
                        Text(
                          state.orderHistoryList[index].showMoreString,
                          style: AppStyle.smallTextStyleDark,
                        )
                      ],
                    );
                  }
                } else {
                  return const SizedBox();
                }
              })
            ],
          );
        } else {
          return SizedBox();
        }
      },
    );
  }
}
