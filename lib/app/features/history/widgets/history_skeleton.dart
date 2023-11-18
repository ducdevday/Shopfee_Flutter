import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:shopfee/app/config/dimens.dart';

import '../../../common/widgets/my_skelton.dart';

class HistorySkeleton extends StatelessWidget {
  const HistorySkeleton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: ListView.separated(
        itemCount: 10,
        itemBuilder: (context, index) => const Padding(
          padding: EdgeInsets.symmetric(
              horizontal: AppDimen.screenPadding),
          child: Row(children: [
            MySkeleton(
              width: 70,
              height: 70,
            ),
            SizedBox(
              width: 4,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MySkeleton(
                    width: 100,
                    height: 20,
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  MySkeleton(
                    width: 200,
                    height: 40,
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 4,
            ),
            Column(
              children: [
                MySkeleton(
                  width: 62,
                  height: 20,
                ),
                SizedBox(
                  height: 4,
                ),
              ],
            )
          ]),
        ),
        separatorBuilder: (context, index) => const Divider(
          height: 10,
          indent: AppDimen.screenPadding,
        ),
      ),
    );
  }
}
