import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shimmer/shimmer.dart';
import 'package:shopfee/app/common/widgets/my_bottom_navigation_bar/cubit/my_bottom_navigation_bar_cubit.dart';
import 'package:shopfee/app/common/widgets/my_bottom_navigation_bar/my_bottom_navigationbar.dart';
import 'package:shopfee/app/common/widgets/my_skelton.dart';
import 'package:shopfee/app/config/color.dart';
import 'package:shopfee/app/config/dimens.dart';
import 'package:shopfee/app/config/routes.dart';
import 'package:shopfee/app/config/style.dart';
import 'package:shopfee/app/features/history/bloc/history_bloc.dart';
import 'package:shopfee/app/features/history/widgets/history_filter.dart';
import 'package:shopfee/app/features/history/widgets/history_item.dart';
import 'package:shopfee/app/features/history/widgets/history_not_auth.dart';
import 'package:shopfee/app/features/history/widgets/history_skeleton.dart';
import 'package:shopfee/app/utils/string_converter_util.dart';
import 'package:shopfee/data/models/order_history.dart';
import 'package:shopfee/data/models/order_type.dart';
import 'package:shopfee/data/models/status_order.dart';

enum HistoryStatus { Processing, Done, Canceled }

class HistoryScreen extends StatefulWidget {
  final MyBottomNavigationBar myBottomNavigationBar;

  const HistoryScreen(this.myBottomNavigationBar, {Key? key}) : super(key: key);

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  final scrollController = ScrollController();
  late bool isLoadingMore;
  late bool cannotLoadMore;
  late HistoryStatus historyStatus;
  late List<OrderHistory> orderHistoryList;

  @override
  void initState() {
    super.initState();
    scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    if (isLoadingMore || cannotLoadMore) return;
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      context
          .read<HistoryBloc>()
          .add(LoadMoreHistory(historyStatus: historyStatus));
    }
  }

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
      body: RefreshIndicator(
        onRefresh: () async {
          context
              .read<HistoryBloc>()
              .add(LoadHistory(historyStatus: historyStatus));
        },
        child: Container(
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
                      return HistoryNotAuthWidget();
                    } else if (state is HistoryLoading) {
                      return HistorySkeleton();
                    } else if (state is HistoryLoaded) {
                      isLoadingMore = state.isLoadMore;
                      cannotLoadMore = state.cannotLoadMore;
                      historyStatus = state.historyStatus;
                      orderHistoryList = state.orderHistoryList;
                      if (orderHistoryList.isNotEmpty) {
                        return ListView.separated(
                          controller:scrollController,
                          itemCount: isLoadingMore
                              ? orderHistoryList.length + 1
                              : orderHistoryList.length,
                          itemBuilder: (context, index) =>index < orderHistoryList.length ? InkWell(
                            onTap: () {
                              Navigator.pushNamed(context, AppRouter.receiptRoute,
                                  arguments: orderHistoryList[index].id);
                            },
                            child: HistoryItem(
                              index: index,
                            ),
                          ) : const Padding(
                            padding: EdgeInsets.all(AppDimen.spacing),
                            child: CupertinoActivityIndicator(),
                          ),
                          separatorBuilder: (context, index) => const Divider(
                            height: 10,
                            thickness: 1,
                          ),
                        );
                      } else {
                        if (state.historyStatus == HistoryStatus.Processing) {
                          return Container(
                            width: double.infinity,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  "assets/icons/ic_coffee.png",
                                  width: 60,
                                  height: 60,
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                Text(
                                  "No Order In Processing",
                                  style: AppStyle.mediumTextStyleDark
                                      .copyWith(color: AppColor.nonactiveColor),
                                )
                              ],
                            ),
                          );
                        } else if (state.historyStatus == HistoryStatus.Done) {
                          return Container(
                            width: double.infinity,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  "assets/icons/ic_coffee.png",
                                  width: 60,
                                  height: 60,
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                Text(
                                  "No Order Has Done",
                                  style: AppStyle.mediumTextStyleDark
                                      .copyWith(color: AppColor.nonactiveColor),
                                )
                              ],
                            ),
                          );
                        } else {
                          return Container(
                            width: double.infinity,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  "assets/icons/ic_coffee.png",
                                  width: 60,
                                  height: 60,
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                Text(
                                  "No Order Has Canceled",
                                  style: AppStyle.mediumTextStyleDark
                                      .copyWith(color: AppColor.nonactiveColor),
                                )
                              ],
                            ),
                          );
                        }
                      }
                    } else {
                      return const SizedBox();
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: widget.myBottomNavigationBar,
    );
  }
}




