import 'package:flutter/material.dart';
import 'package:shopfee/app/config/dimens.dart';
import 'package:shopfee/app/config/style.dart';
import 'package:shopfee/data/models/voucher.dart';

class VoucherScreen extends StatelessWidget {
  const VoucherScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Voucher"),
      ),
      body: SingleChildScrollView(
        child: Wrap(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppDimen.screenPadding),
              child: TextField(
                style: AppStyle.smallTextStyleDark,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(8),
                  suffixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16)),
                  hintText: "Enter the voucher here",
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(AppDimen.screenPadding),
              child: ListView.separated(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Row(
                      children: [
                        Image.asset(
                          "assets/icons/ic_vnpay.png",
                          width: 32,
                          height: 32,
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Expanded(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              Voucher.vouchers[index].name,
                              style: AppStyle.mediumTitleStyleDark,
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Text(
                              "Minimum spend ${Voucher.vouchers[index].minium}",
                              style: AppStyle.normalTextStyleDark,
                            ),
                          ],
                        )),
                        TextButton(onPressed: () {}, child: Text("Apply"))
                      ],
                    );
                  },
                  separatorBuilder: (context, int index) => Divider(
                        height: 24,
                      ),
                  itemCount: Voucher.vouchers.length),
            )
          ],
        ),
      ),
    );
  }
}
