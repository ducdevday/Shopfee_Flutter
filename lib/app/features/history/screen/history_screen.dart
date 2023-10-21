import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shimmer/shimmer.dart';
import 'package:shopfee/app/common/widgets/my_bottom_navigationbar.dart';
import 'package:shopfee/app/common/widgets/my_error.dart';
import 'package:shopfee/app/common/widgets/my_loading.dart';
import 'package:shopfee/app/common/widgets/my_skelton.dart';
import 'package:shopfee/app/config/color.dart';
import 'package:shopfee/app/config/dimens.dart';
import 'package:shopfee/app/config/style.dart';
import 'package:shopfee/app/features/history/bloc/history_bloc.dart';
import 'package:shopfee/app/features/home/bloc/home_bloc.dart';
import 'package:shopfee/app/utils/my_converter.dart';
import 'package:shopfee/data/models/order_type.dart';
import 'package:shopfee/data/repositories/order/order_repository.dart';

enum HistoryStatus { Processing, Done, Canceled }

class HistoryScreen extends StatelessWidget {
  final MyBottomNavigationBar myBottomNavigationBar;

  const HistoryScreen(this.myBottomNavigationBar, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("History"),
        automaticallyImplyLeading: false,
        centerTitle: true,
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Divider(height: 1),
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            const SizedBox(
              height: AppDimen.spacing,
            ),
            const HistoryFilter(),
            Expanded(
              child: BlocBuilder<HistoryBloc, HistoryState>(
                builder: (context, state) {
                  if (state is HistoryNotAuth) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 120,
                            height: 120,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                    width: 1, color: AppColor.primaryColor)),
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: SvgPicture.asset(
                                "assets/icons/ic_shopping_bag.svg",
                                width: 120,
                                height: 120,
                                color: AppColor.primaryColor,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Order & History",
                            style: AppStyle.largeTitleStyleDark,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Follow order and history of you",
                            style: AppStyle.mediumTextStyleDark,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            padding: EdgeInsets.all(AppDimen.screenPadding),
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.pushNamed(context, "/welcome");
                              },
                              child: const Text("Register / Log in"),
                              style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 12, horizontal: 24),
                                  disabledBackgroundColor:
                                  const Color(0xffCACACA),
                                  disabledForegroundColor: AppColor.lightColor,
                                  textStyle: AppStyle.mediumTextStyleDark,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  )),
                            ),
                          ),
                        ],
                      ),
                    );
                  } else if (state is HistoryLoading) {
                    return Shimmer.fromColors(
                      baseColor: Colors.grey.shade300,
                      highlightColor: Colors.grey.shade100,
                      child: ListView.separated(
                        itemCount: 10,
                        itemBuilder: (context, index) => const Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: AppDimen.screenPadding),
                          child: Row(children: [
                            MySkeleton(
                              width: 70,
                              height: 70,
                            ),
                            SizedBox(
                              width: 4,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  MySkeleton(
                                    width: 100,
                                    height: 20,
                                  ),
                                  SizedBox(
                                    height: 4,
                                  ),
                                  MySkeleton(
                                    width: 200,
                                    height: 30,
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 4,
                            ),
                            Column(
                              children: [
                                MySkeleton(
                                  width: 62,
                                  height: 20,
                                ),
                                SizedBox(
                                  height: 4,
                                ),
                                MySkeleton(
                                  width: 62,
                                  height: 20,
                                ),
                              ],
                            )
                          ]),
                        ),
                        separatorBuilder: (context, index) => const Divider(
                          height: 10,
                          indent: AppDimen.screenPadding,
                        ),
                      ),
                    );
                  } else if (state is HistoryLoaded) {
                    return ListView.separated(
                      itemCount: state.orderHistoryList.length,
                      itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: AppDimen.screenPadding),
                        child: InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, "/receipt",
                                arguments: state.orderHistoryList[index].id);
                          },
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
                                  Text(
                                    state.orderHistoryList[index]
                                        .productNameString,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: AppStyle.mediumTextStyleDark
                                        .copyWith(
                                            color: AppColor.headingColor,
                                            height: 2),
                                  ),
                                  Text(
                                    "${MyConverter.formattedTime(state.orderHistoryList[index].timeLastEvent)} - ${MyConverter.formattedDate(state.orderHistoryList[index].timeLastEvent)}",
                                    style: AppStyle.normalTextStyleDark,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              width: 4,
                            ),
                            Column(
                              children: [
                                Text(
                                  state
                                      .orderHistoryList[index].totalPriceString,
                                  style: AppStyle.mediumTextStyleDark.copyWith(
                                      color: AppColor.headingColor, height: 2),
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                                Text(
                                  state.orderHistoryList[index].statusLastEvent
                                      .name,
                                  style: AppStyle.mediumTextStyleDark
                                      .copyWith(color: AppColor.primaryColor),
                                ),
                              ],
                            )
                          ]),
                        ),
                      ),
                      separatorBuilder: (context, index) => const Divider(
                        height: 10,
                        indent: AppDimen.screenPadding,
                      ),
                    );
                  } else {
                    return const SizedBox();
                  }
                },
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: myBottomNavigationBar,
    );
  }
}

class HistoryFilter extends StatelessWidget {
  const HistoryFilter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HistoryBloc, HistoryState>(
      buildWhen: (previousState, state) => state is! HistoryLoading,
      builder: (context, state) {
        if (state is HistoryLoaded) {
          return Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: AppDimen.screenPadding),
            child: Row(
              children: [
                FilterChip(
                    labelPadding:
                        const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                    showCheckmark: false,
                    selectedColor: AppColor.primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    label: Text(
                      HistoryStatus.Processing.name,
                      style: AppStyle.smallTextStyleDark.copyWith(
                          fontWeight: FontWeight.bold,
                          color: state.historyStatus == HistoryStatus.Processing
                              ? Colors.white
                              : AppColor.headingColor),
                    ),
                    selected: state.historyStatus == HistoryStatus.Processing,
                    onSelected: (bool selected) {
                      if (selected) {
                        context.read<HistoryBloc>().add(const LoadHistory(
                            historyStatus: HistoryStatus.Processing));
                      }
                    }),
                const SizedBox(width: 8),
                FilterChip(
                    labelPadding:
                        const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                    showCheckmark: false,
                    selectedColor: AppColor.primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    label: Text(
                      HistoryStatus.Done.name,
                      style: AppStyle.smallTextStyleDark.copyWith(
                          fontWeight: FontWeight.bold,
                          color: state.historyStatus == HistoryStatus.Done
                              ? Colors.white
                              : AppColor.headingColor),
                    ),
                    selected: state.historyStatus == HistoryStatus.Done,
                    onSelected: (bool selected) {
                      if (selected) {
                        context.read<HistoryBloc>().add(const LoadHistory(
                            historyStatus: HistoryStatus.Done));
                      }
                    }),
                const SizedBox(width: 8),
                FilterChip(
                    labelPadding:
                        const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                    showCheckmark: false,
                    selectedColor: AppColor.primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    label: Text(
                      HistoryStatus.Canceled.name,
                      style: AppStyle.smallTextStyleDark.copyWith(
                          fontWeight: FontWeight.bold,
                          color: state.historyStatus == HistoryStatus.Canceled
                              ? Colors.white
                              : AppColor.headingColor),
                    ),
                    selected: state.historyStatus == HistoryStatus.Canceled,
                    onSelected: (bool selected) {
                      if (selected) {
                        context.read<HistoryBloc>().add(const LoadHistory(
                            historyStatus: HistoryStatus.Canceled));
                      }
                    }),
              ],
            ),
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
