part of vnpay;

class VnPayPage extends StatefulWidget {
  static const String route = "/vnpay";
  final OrderResult orderResult;

  const VnPayPage({required this.orderResult, Key? key}) : super(key: key);

  @override
  State<VnPayPage> createState() => _VnPayPageState();
}

class _VnPayPageState extends State<VnPayPage> {
  late final VnPayCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = ServiceLocator.sl<VnPayCubit>();
  }

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (didPop) async {
        if (didPop) {
          return;
        }
        //? Hủy thanh toán
        _cubit.handlePayment(transactionId: widget.orderResult.transactionId!);
        NavigationUtil.pushNamedAndRemoveUntil(ReceiptPage.route,
                arguments: widget.orderResult.orderId)
            .then((value) => NavigationUtil.pushNamed(DefaultPage.route));
      },
      child: Scaffold(
        body: BlocProvider(
          create: (context) => _cubit,
          child: BlocConsumer<VnPayCubit, VnPayState>(
            listener: (context, state) {
              if (state is VnPayFinished) {
                NavigationUtil.pushNamedAndRemoveUntil(ReceiptPage.route,
                        arguments: widget.orderResult.orderId)
                    .then(
                        (value) => NavigationUtil.pushNamed(DefaultPage.route));
              }
            },
            builder: (context, state) {
              return WebViewWidget(
                  controller: WebViewController()
                    ..setJavaScriptMode(JavaScriptMode.unrestricted)
                    ..setNavigationDelegate(
                      NavigationDelegate(
                        onProgress: (int progress) {
                          // Update loading bar.
                          // EasyLoading.showProgress(progress.toDouble(), status: "Processing...",maskType: EasyLoadingMaskType.black);
                        },
                        onPageStarted: (String url) {
                          final onPageStarted = url;
                        },
                        onPageFinished: (String url) {
                          final onPageFinished = url;
                        },
                        onWebResourceError: (WebResourceError error) {
                          final webError = error;
                          _cubit.handlePayment(
                              transactionId: widget.orderResult.transactionId!);
                        },
                        onNavigationRequest: (NavigationRequest request) {
                          final onNavigationRequest = request.url;
                          // ? VNPAY Thanh toán thành công khi vnp_ResponseCode=00, thất bại khi vnp_ResponseCode!=00
                          if (request.url.contains("vnp_ResponseCode")) {
                            if (request.url.contains("vnp_ResponseCode=00")) {
                              _cubit.handlePayment(
                                  transactionId:
                                      widget.orderResult.transactionId!);
                              return NavigationDecision.prevent;
                            } else {
                              _cubit.handlePayment(
                                  transactionId:
                                      widget.orderResult.transactionId!);
                              return NavigationDecision.prevent;
                            }
                          }
                          //? ZaloPAY
                          else if (request.url.contains("status")) {
                            _cubit.handlePayment(
                                transactionId:
                                    widget.orderResult.transactionId!);
                            return NavigationDecision.prevent;
                          }
                          return NavigationDecision.navigate;
                        },
                      ),
                    )
                    ..loadRequest(Uri.parse(widget.orderResult.paymentUrl!)));
            },
          ),
        ),
      ),
    );
  }
}
