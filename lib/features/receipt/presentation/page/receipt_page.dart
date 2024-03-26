part of receipt;

class ReceiptPage extends StatefulWidget {
  static const String route = "/receipt";
  final String orderId;

  const ReceiptPage({Key? key, required this.orderId}) : super(key: key);

  @override
  State<ReceiptPage> createState() => _ReceiptPageState();
}

class _ReceiptPageState extends State<ReceiptPage> {
  late final ReceiptBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = ServiceLocator.sl<ReceiptBloc>()
      ..add(ReceiptLoadInformation(orderId: widget.orderId));
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
              return SingleChildScrollView(
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
                                border:
                                    Border.all(color: const Color(0xffefebe9)),
                                borderRadius: BorderRadius.circular(16)),
                            child: Column(
                              children: [
                                const ReceiptInformation(),
                                Container(
                                  height: 4,
                                  color: const Color(0xffEFEBE9),
                                ),
                                const ReceiptStatusInformation(),
                                Container(
                                  height: 4,
                                  color: const Color(0xffEFEBE9),
                                ),
                                const BoughtList(),
                                Container(
                                  height: 4,
                                  color: const Color(0xffEFEBE9),
                                ),
                                const PaymentSummary(),
                                const NoteReceipt(),
                              ],
                            ),
                          ),
                          Builder(builder: (context) {
                            if (state.lastEventLog.orderStatus !=
                                OrderStatus.CANCELED) {
                              return Center(
                                  child: SvgPicture.asset(AppPath.icSuccess));
                            } else {
                              return Center(
                                  child: SvgPicture.asset(AppPath.icCancel));
                            }
                          }),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            } else {
              return const MyErrorPage();
            }
          },
        ),
        bottomNavigationBar: ReceiptBottomAction(),
      ),
    );
  }
}
