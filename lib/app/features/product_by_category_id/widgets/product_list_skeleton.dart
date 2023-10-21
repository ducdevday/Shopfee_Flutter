import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:shopfee/app/config/dimens.dart';

import 'product_item_skeleton.dart';

class ProductListSkeleton extends StatelessWidget {
  const ProductListSkeleton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: ListView.separated(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          padding: EdgeInsets.only(top: 40),
          itemCount: 10,
          itemBuilder: (context, index) => Padding(
            padding: const EdgeInsets.symmetric(horizontal:AppDimen.screenPadding),
            child: ProductItemSkeleton(),
          ),
          separatorBuilder: (context, int index) => Divider(
            height: 8,
            thickness: 0.75,
          ),
        ),
      ),
    );
  }
}

