part of store;

class StoreListView extends StatelessWidget {
  const StoreListView({
    super.key,
    required this.storeList,
    required this.isLoadingMore, required this.currentViewType,
  });

  final List<StoreInformationEntity> storeList;
  final bool isLoadingMore;
  final StoreViewType currentViewType;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: currentViewType == StoreViewType.List_View,
      maintainSize: true,
      maintainAnimation: true,
      maintainState: true,
      child: ListView.separated(
        padding:
        const EdgeInsets.only(top: AppDimen.spacing, left: AppDimen.spacing, right: AppDimen.spacing),
        itemBuilder: (context, index) => index <
            storeList.length
            ? StoreItem(store: storeList[index])
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
    );
  }
}
