import 'package:flutter/material.dart';
import 'package:shopfee/app/common/widgets/my_skelton.dart';

class ProductItemSkeleton extends StatelessWidget {
  const ProductItemSkeleton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MySkeleton(
            height: 70,
            width: 70,
            isCircle: true,
          ),
          SizedBox(
            width: 20,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(top: 4.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MySkeleton(
                    width: 200,
                    height: 20,
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  MySkeleton(
                    width: 300,
                    height: 30,
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            width: 20,
          ),
          Padding(
            padding: EdgeInsets.only(top: 4.0),
            child: MySkeleton(
              width: 65,
              height: 20,
            ),
          )
        ],
      ),
    );
  }
}
