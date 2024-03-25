part of review;

class ReviewPage extends StatelessWidget {
  static const String route = "/review";
  final List<ReceiptProductEntity>? itemList;

  const ReviewPage({Key? key, this.itemList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffEFEBE9),
      appBar: AppBar(
        backgroundColor: Colors.white,
          title: Text("Review Order"),
          centerTitle: true,
          bottom: const PreferredSize(
            preferredSize: Size.fromHeight(1),
            child: Divider(height: 1),
          )),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: [
          //     Text(
          //       "ID Transaction",
          //       style: AppStyle.mediumTitleStyleDark,
          //     ),
          //     Text(
          //       widget.orderId,
          //       style: AppStyle.normalTextStyleDark,
          //     )
          //   ],
          // ),
          // SizedBox(
          //   height: 8,
          // ),
          Expanded(
            child: SingleChildScrollView(
              child: BoughtList(
                itemList: itemList,
              ),
            ),
          ),
          Align(
              alignment: Alignment.center,
              child: Container(
                padding: EdgeInsets.all(AppDimen.spacing),
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("See Order Detail"),
                    style: AppStyle.elevatedButtonStylePrimary),
              ))
        ],
      ),
    );
  }
}
