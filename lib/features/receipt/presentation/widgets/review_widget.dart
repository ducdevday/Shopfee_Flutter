part of receipt;

class ReviewWidget extends StatelessWidget {
  const ReviewWidget({
    super.key,
    required this.orderId,
  });

  final String orderId;

  @override
  Widget build(BuildContext context) {
    return SizedBox();
    // return BlocBuilder<ReceiptBloc, ReceiptState>(
    //   builder: (context, state) {
    //     if (state is ReceiptLoaded && state.isSuccess == true) {
    //       return Column(
    //         children: [
    //           Container(
    //             height: 4,
    //             color: Color(0xffEFEBE9),
    //           ),
    //           Container(
    //             padding: EdgeInsets.all(8),
    //             height: 70,
    //             child: Row(
    //               children: [
    //                 Container(
    //                   height: double.infinity,
    //                   padding: EdgeInsets.all(8),
    //                   decoration: BoxDecoration(
    //                       color: Colors.white,
    //                       borderRadius: const BorderRadius.only(
    //                           bottomLeft: Radius.circular(8),
    //                           topLeft: Radius.circular(8)),
    //                       border: Border.all(color: Color(0xffF0F0F0))),
    //                   child: Row(
    //                     children: [
    //                       Builder(builder: (context) {
    //                         if (state.receipt.review != null) {
    //                           return Text(
    //                             "${state.receipt.review!.rating}",
    //                             style: AppStyle.mediumTextStyleDark,
    //                           );
    //                         } else {
    //                           return SizedBox();
    //                         }
    //                       }),
    //                       Icon(
    //                         Icons.star_rounded,
    //                         color: Colors.amber,
    //                       )
    //                     ],
    //                   ),
    //                 ),
    //                 Expanded(
    //                   child: Container(
    //                     padding: EdgeInsets.all(8),
    //                     decoration: const BoxDecoration(
    //                       color: Color(0xffF0F0F0),
    //                       borderRadius: BorderRadius.only(
    //                           bottomRight: Radius.circular(8),
    //                           topRight: Radius.circular(8)),
    //                     ),
    //                     child: Builder(builder: (context) {
    //                       if (state.receipt.review == null) {
    //                         return Column(
    //                           crossAxisAlignment: CrossAxisAlignment.start,
    //                           children: [
    //                             Text(
    //                               "You haven't leave a review yet",
    //                               style: AppStyle.mediumTextStyleDark,
    //                             ),
    //                             SizedBox(
    //                               height: 4,
    //                             ),
    //                             InkWell(
    //                               onTap: () {
    //                                 Navigator.pushNamed(context,AppRouter.reviewRoute,
    //                                     arguments: orderId)
    //                                     .then((value) => context
    //                                     .read<ReceiptBloc>()
    //                                     .add(
    //                                     LoadReceipt(orderId: orderId)));
    //                               },
    //                               child: Text(
    //                                 "Review now",
    //                                 style: AppStyle.normalTextStylePrimary,
    //                               ),
    //                             )
    //                           ],
    //                         );
    //                       } else {
    //                         return Column(
    //                           crossAxisAlignment: CrossAxisAlignment.start,
    //                           children: [
    //                             Text(
    //                               "Thank for your review",
    //                               style: AppStyle.mediumTextStyleDark,
    //                             ),
    //                             SizedBox(
    //                               height: 4,
    //                             ),
    //                             Text(
    //                               "\"${state.receipt.review!.content}\"",
    //                               style: AppStyle.normalTextStyleDark,
    //                               maxLines: 1,
    //                               overflow: TextOverflow.ellipsis,
    //                             )
    //                           ],
    //                         );
    //                       }
    //                     }),
    //                   ),
    //                 )
    //               ],
    //             ),
    //           ),
    //         ],
    //       );
    //     } else {
    //       return SizedBox();
    //     }
    //   },
    // );
  }
}
