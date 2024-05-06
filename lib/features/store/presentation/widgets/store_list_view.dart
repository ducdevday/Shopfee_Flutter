part of store;

class StoreListView extends StatelessWidget {
  final RefreshController refreshController;
  final List<StoreInformationEntity> storeList;
  final bool isLoadingMore;
  final StoreViewType currentViewType;
  final String fromRoute;

  const StoreListView({
    super.key,
    required this.storeList,
    required this.isLoadingMore, required this.currentViewType, required this.fromRoute, required this.refreshController,
  });

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: currentViewType == StoreViewType.List_View,
      maintainSize: true,
      maintainAnimation: true,
      maintainState: true,
      child: SmartRefresher(
        controller: refreshController,
        enablePullUp: false,
        physics: BouncingScrollPhysics(),
        onRefresh: () async {
          context.read<StoreBloc>().add(StoreRefreshInformation());
          refreshController.refreshCompleted();
        },
        child: ListView.separated(
          padding:
          const EdgeInsets.only(top: AppDimen.spacing, left: AppDimen.spacing, right: AppDimen.spacing),
          itemBuilder: (context, index) => index <
              storeList.length
              ? StoreItem(store: storeList[index], fromRoute: fromRoute)
              : const Padding(
            padding: EdgeInsets.all(AppDimen.spacing),
            child: CupertinoActivityIndicator(),
          ),
          separatorBuilder: (context, index) =>
          const SizedBox(
            height: AppDimen.spacing,
          ),
          itemCount: isLoadingMore
              ? storeList.length + 1
              : storeList.length,
        ),
      ),
    );
  }
}

