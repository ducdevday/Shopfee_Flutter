import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:shopfee/app/common/widgets/my_skelton.dart';
import 'package:shopfee/app/config/dimens.dart';

class HomeSkeleton extends StatelessWidget {
  const HomeSkeleton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: AppDimen.spacing,
            ),
            Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                child: MySkeleton(
                  width: MediaQuery.of(context).size.width - 40,
                  height: 137,
                  radius: 16,
                )),
            const SizedBox(
              height: AppDimen.spacing,
            ),
            Container(
              height: 80,
              margin: const EdgeInsets.symmetric(
                  horizontal: AppDimen.screenPadding),
              width: MediaQuery.of(context).size.width,
              child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => const MySkeleton(
                        width: 60,
                        height: 80,
                        radius: 16,
                      ),
                  separatorBuilder: (context, index) => const SizedBox(
                        width: 20,
                      ),
                  itemCount: 5),
            ),
            const SizedBox(
              height: 16,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: AppDimen.screenPadding),
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: MySkeleton(
                    width: 130,
                    height: 20,
                  )),
            ),
            const SizedBox(
              height: 8,
            ),
            ListView.separated(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 8,
              itemBuilder: (context, index) => const Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: AppDimen.screenPadding),
                child: HomeProductSkeleton(),
              ),
              separatorBuilder: (context, int index) =>
              const Divider(
                height: 8,
                thickness: 0.75,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HomeProductSkeleton extends StatelessWidget {
  const HomeProductSkeleton({Key? key}) : super(key: key);

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
