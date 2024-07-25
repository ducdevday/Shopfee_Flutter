part of history;

class HistoryPage extends StatefulWidget {
  static const String route = "/history";

  const HistoryPage({Key? key}) : super(key: key);

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  late ValueNotifier historyStatusNotifier;

  @override
  void initState() {
    historyStatusNotifier = ValueNotifier(HistoryStatus.WAITING);
    super.initState();
  }

  @override
  void dispose() {
    historyStatusNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshConfiguration.copyAncestor(
      context: context,
      child: Scaffold(
        appBar: AppBar(
          title: Text(R.history.tr()),
          centerTitle: true,
          bottom: const PreferredSize(
            preferredSize: Size.fromHeight(1),
            child: Divider(height: 1),
          ),
        ),
        body: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              const SizedBox(
                height: AppDimen.spacing,
              ),
              ValueListenableBuilder(
                valueListenable: historyStatusNotifier,
                builder: (BuildContext context, historyStatus, Widget? child) {
                  return HistoryFilter(
                    historyStatus: historyStatus,
                    callback: (HistoryStatus status) =>
                    historyStatusNotifier.value = status,
                  );
                },
              ),
              ValueListenableBuilder(
                valueListenable: historyStatusNotifier,
                builder: (BuildContext context, historyStatus, Widget? child) {
                  return Expanded(
                    child: HistoryList(key: ValueKey(DateTime.now().millisecondsSinceEpoch.toString()),historyStatus: historyStatus),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
