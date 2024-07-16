part of receipt;

class ReceiptPage extends StatefulWidget {
  static const String route = "/receipt";
  final String orderId;

  const ReceiptPage({Key? key, required this.orderId}) : super(key: key);

  @override
  State<ReceiptPage> createState() => _ReceiptPageState();
}

class _ReceiptPageState extends State<ReceiptPage> {
  late ReceiptBloc _bloc;
  final SocketMethod socketMethod = ServiceLocator.sl<SocketMethod>();

  @override
  void initState() {
    super.initState();
    _bloc = ServiceLocator.sl<ReceiptBloc>()
      ..add(ReceiptLoadInformation(orderId: widget.orderId));
    socketMethod.joinUser(userId: SharedService.getUserId()!);
    socketMethod.employeeUpdateOrderListener((data) {
      if (!_bloc.isClosed) {
        _bloc.add(ReceiptRefreshInformation(orderId: widget.orderId));
      }
    });
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
      child: Scaffold(
        body: BlocBuilder<ReceiptBloc, ReceiptState>(
          builder: (context, state) {
            if (state is ReceiptLoadInProcess) {
              return const MyLoadingPage();
            } else if (state is ReceiptLoadSuccess) {
              return RefreshIndicator(
                onRefresh: () async {
                  if (!_bloc.isClosed) {
                    _bloc.add(
                        ReceiptRefreshInformation(orderId: widget.orderId));
                  }
                },
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: AppDimen.screenPadding,
                        right: AppDimen.screenPadding,
                        bottom: AppDimen.screenPadding),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: AppDimen.screenPadding * 2,
                                bottom: AppDimen.screenPadding),
                            child: InkWell(
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () {
                                NavigationUtil.pop(
                                    result: state.isCancelButtonClicked);
                              },
                              child: const Icon(Icons.close_rounded),
                            ),
                          ),
                        ),
                        Stack(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(top: 40),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: AppColor.scaffoldColorBackground),
                                  borderRadius: BorderRadius.circular(16)),
                              child: Column(
                                children: [
                                  const ReceiptInformation(),
                                  Container(
                                    height: 4,
                                    color: AppColor.scaffoldColorBackground,
                                  ),
                                  ReceiptStatusInformation(
                                    orderId: widget.orderId,
                                  ),
                                  Container(
                                    height: 4,
                                    color: AppColor.scaffoldColorBackground,
                                  ),
                                  const BoughtList(),
                                  Container(
                                    height: 4,
                                    color: AppColor.scaffoldColorBackground,
                                  ),
                                  const GiftList(),
                                  const PaymentSummary(),
                                  const NoteReceipt(),
                                ],
                              ),
                            ),
                            Builder(builder: (context) {
                              if (state.lastEventLog.orderStatus ==
                                  OrderStatus.NOT_RECEIVED) {
                                return Center(
                                    child:
                                        SvgPicture.asset(AppPath.icNotReceive));
                              } else if (state.lastEventLog.orderStatus ==
                                  OrderStatus.CANCELED) {
                                return Center(
                                    child: SvgPicture.asset(AppPath.icCancel));
                              } else {
                                return Center(
                                    child: SvgPicture.asset(AppPath.icSuccess));
                              }
                            }),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            } else {
              return const MyErrorPage();
            }
          },
        ),
        bottomNavigationBar: ReceiptBottomAction(
          orderId: widget.orderId,
        ),
      ),
    );
  }
}
