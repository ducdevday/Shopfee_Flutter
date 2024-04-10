part of refund;

class RefundPage extends StatefulWidget {
  static const String route = "/refund";
  final String? orderId;

  const RefundPage({Key? key, this.orderId}) : super(key: key);

  @override
  State<RefundPage> createState() => _RefundPageState();
}

class _RefundPageState extends State<RefundPage> {
  late final RefundBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = ServiceLocator.sl<RefundBloc>();
  }


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _bloc,
      child: RefreshConfiguration.copyAncestor(
        context: context,
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              title: Text(widget.orderId == null
                  ? "Refund Request"
                  : "Refund Detail"),
              centerTitle: true,
              bottom: const PreferredSize(
                preferredSize: Size.fromHeight(1),
                child: Divider(height: 1),
              ),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(AppDimen.screenPadding),
                child: Column(
                  children: [
                  ],
                ),
              ),
            )
        ),
      ),
    );
  }
}
