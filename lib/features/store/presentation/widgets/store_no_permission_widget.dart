part of store;
class StoreNoPermission extends StatelessWidget {
  final int initPage;
  final int initSize;
  const StoreNoPermission({super.key, required this.initPage, required this.initSize});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Image.asset(
            AppPath.icNoLocation,
            width: 60,
            height: 60,
          ),
          const SizedBox(
            height: 16,
          ),
          Text(
            "Please enable location to see all Stores",
            style: AppStyle.normalTextStyleDark,
          ),
          const SizedBox(
            height: 8,
          ),
          ElevatedButton(
              onPressed: () {
                context.read<StoreBloc>().add(StoreLoadInformation(
                    initPage: initPage, initSize: initSize));
              },
              style: AppStyle.elevatedButtonStylePrimary,
              child: const Text("Enable"))
        ],
      ),
    );
  }
}
