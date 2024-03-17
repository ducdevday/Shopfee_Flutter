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
    return Scaffold(
      body: BlocProvider(
        create: (context) => _bloc,
        child: BlocBuilder<ReceiptBloc, ReceiptState>(
          builder: (context, state) {
            if (state is ReceiptLoadInProcess) {
              return MyLoadingPage();
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
                            child: Icon(Icons.close_rounded),
                          ),
                        ),
                      ),
                      Stack(
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 40),
                            decoration: BoxDecoration(
                                border: Border.all(color: Color(0xffefebe9)),
                                borderRadius: BorderRadius.circular(16)),
                            child: Column(
                              children: [
                                ReceiptInformation(),
                                // Review(orderId: orderId),
                                Container(
                                  height: 4,
                                  color: Color(0xffEFEBE9),
                                ),
                                ReceiptStatusInformation(),
                                Container(
                                  height: 4,
                                  color: Color(0xffEFEBE9),
                                ),
                                ItemList(),
                                Container(
                                  height: 4,
                                  color: Color(0xffEFEBE9),
                                ),
                                PaymentSummary(),
                                NoteReceipt(),
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
                      // SizedBox(height: 20),
                      // ElevatedButton(
                      //     onPressed: () {
                      //       Navigator.pushNamed(context, "/review",
                      //           arguments: orderId);
                      //     },
                      //     child: Text(
                      //       "Review",
                      //     ),
                      //     style: ElevatedButton.styleFrom(
                      //         backgroundColor:
                      //             AppColor.primaryColorBackground,
                      //         foregroundColor: AppColor.primaryColor,
                      //         disabledBackgroundColor:
                      //             const Color(0xffCACACA),
                      //         disabledForegroundColor: AppColor.lightColor,
                      //         shape: RoundedRectangleBorder(
                      //             borderRadius: BorderRadius.circular(16))))
                    ],
                  ),
                ),
              );
            } else {
              return MyErrorPage();
            }
          },
        ),
      ),
    );
  }
}
