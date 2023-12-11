import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shopfee/app/config/color.dart';
import 'package:shopfee/app/config/routes.dart';
import 'package:shopfee/app/features/vnpay/cubit/vnpay_cubit.dart';
import 'package:shopfee/data/repositories/firebase/firebase_repository.dart';
import 'package:shopfee/data/repositories/order/order_repository.dart';
import 'package:shopfee/data/repositories/transaction/transaction_repository.dart';
import 'package:webview_flutter/webview_flutter.dart';

class VNPayScreen extends StatefulWidget {
  final String paymentUrl;
  final String orderId;
  final String transactionId;

  const VNPayScreen(
      {Key? key,
      required this.paymentUrl,
      required this.orderId,
      required this.transactionId})
      : super(key: key);

  @override
  State<VNPayScreen> createState() => _VNPayScreenState();
}

class _VNPayScreenState extends State<VNPayScreen> {
  late VnpayCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = VnpayCubit(
        transactionRepository: context.read<TransactionRepository>(),
        orderRepository: context.read<OrderRepository>(),
        firebaseRepository: context.read<FirebaseRepository>()
    )
      ..initVnpay();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        //? Hủy thanh toán
        _cubit.handlePayment(
            transactionId: widget.transactionId, orderId: widget.orderId);
        // Navigator.pushNamed(context, "/receipt", arguments: widget.orderId);
        return Future.value(false);
      },
      child: Scaffold(
        body: BlocProvider(
          create: (context) => _cubit,
          child: BlocConsumer<VnpayCubit, VnpayState>(
            listener: (context, state) {
              if (state is VnpaySuccess) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: const Text("Payment success"),
                  backgroundColor: AppColor.primaryColor,
                ));
                Navigator.pushNamed(context, AppRouter.receiptRoute,
                    arguments: widget.orderId);
              } else if (state is VnpayCanceled) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: const Text("Payment canceled"),
                  backgroundColor: AppColor.primaryColor,
                ));
                Navigator.pushNamed(context, AppRouter.receiptRoute,
                    arguments: widget.orderId);
              }
            },
            builder: (context, state) {
              if (state is VnpayLoaded) {
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
                                transactionId: widget.transactionId,
                                orderId: widget.orderId);
                          },
                          onNavigationRequest: (NavigationRequest request) {
                            // if (request.url.startsWith('https://www.youtube.com/')) {
                            //   return NavigationDecision.prevent;
                            // }
                            // return NavigationDecision.navigate;
                            final onNavigationRequest = request.url;
                            // ? Thanh toán thành công khi vnp_ResponseCode=00, thất bại khi vnp_ResponseCode!=00
                            if (request.url.contains("vnp_ResponseCode")) {
                              if (request.url.contains("vnp_ResponseCode=00")) {
                                _cubit.handlePayment(
                                    transactionId: widget.transactionId,
                                    orderId: widget.orderId);
                                return NavigationDecision.prevent;
                              } else {
                                _cubit.handlePayment(
                                    transactionId: widget.transactionId,
                                    orderId: widget.orderId);
                                return NavigationDecision.prevent;
                              }
                            }
                            return NavigationDecision.navigate;
                          },
                        ),
                      )
                      ..loadRequest(Uri.parse(widget.paymentUrl)));
              } else {
                return SizedBox();
              }
            },
          ),
        ),
      ),
    );
  }
}
