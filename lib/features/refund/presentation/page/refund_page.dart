part of refund;

class RefundPage extends StatefulWidget {
  static const String route = "/refund";
  final String orderId;
  final RefundRequestStatus refundRequestStatus;

  const RefundPage(
      {Key? key, required this.orderId, required this.refundRequestStatus})
      : super(key: key);

  @override
  State<RefundPage> createState() => _RefundPageState();
}

class _RefundPageState extends State<RefundPage> {
  late final RefundBloc _bloc;
  List<File> mediaList = [];
  String note = "";

  @override
  void initState() {
    super.initState();
    _bloc = ServiceLocator.sl<RefundBloc>();
    if (widget.refundRequestStatus == RefundRequestStatus.REFUNDED) {
      _bloc.add(RefundLoadDetail(orderId: widget.orderId));
    } else {
      _bloc.add(RefundInitRequest());
    }
  }

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
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
              title: Text(R.refundRequest.tr()),
              centerTitle: true,
              bottom: const PreferredSize(
                preferredSize: Size.fromHeight(1),
                child: Divider(height: 1),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(AppDimen.screenPadding),
              child: BlocConsumer<RefundBloc, RefundState>(
                listener: (context, state) {
                  if (state is RefundRequestPhase2State) {
                    mediaList = state.mediaList;
                    note = state.note;
                  } else if (state is RefundRequestFinished) {
                    const haveChanged = true;
                    NavigationUtil.pop(result: haveChanged);
                  }
                },
                builder: (context, state) {
                  switch (state) {
                    case RefundRequestPhase1State():
                      return RefundRequestPhase1Widget(
                          mediaList: mediaList, note: note);
                    case RefundRequestPhase2State():
                      return RefundRequestPhase2Widget(
                        orderId: widget.orderId,
                      );
                    case RefundLoadDetailSuccessState():
                      return RefundDetailWidget();
                    case RefundLoadDetailFailure():
                      return MyErrorWidget();
                    default:
                      return SizedBox();
                  }
                },
              ),
            )),
      ),
    );
  }
}
