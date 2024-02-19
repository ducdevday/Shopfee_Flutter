part of home;

class HomeSkeleton extends StatelessWidget {
  const HomeSkeleton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(
            height: AppDimen.spacing,
          ),
          Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              child: Shimmer.fromColors(
                baseColor: Colors.grey.shade300,
                highlightColor: Colors.grey.shade100,
                child: MySkeletonRectangle(
                  width: MediaQuery.of(context).size.width - 40,
                  height: 137,
                  radius: 16,
                ),
              )),
          const SizedBox(
            height: AppDimen.spacing,
          ),
          Container(
            height: 80,
            margin:
                const EdgeInsets.symmetric(horizontal: AppDimen.screenPadding),
            width: MediaQuery.of(context).size.width,
            child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) => Shimmer.fromColors(
                      baseColor: Colors.grey.shade300,
                      highlightColor: Colors.grey.shade100,
                      child: const MySkeletonRectangle(
                        width: 60,
                        height: 80,
                        radius: 16,
                      ),
                    ),
                separatorBuilder: (context, index) => const SizedBox(
                      width: 20,
                    ),
                itemCount: 5),
          ),
          const SizedBox(
            height: 16,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppDimen.screenPadding),
            child: Align(
                alignment: Alignment.centerLeft,
                child: Shimmer.fromColors(
                  baseColor: Colors.grey.shade300,
                  highlightColor: Colors.grey.shade100,
                  child: const MySkeletonRectangle(
                    width: 130,
                    height: 20,
                  ),
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
              padding: EdgeInsets.symmetric(horizontal: AppDimen.screenPadding),
              child: HomeProductSkeleton(),
            ),
            separatorBuilder: (context, int index) => const Divider(
              height: 8,
              thickness: 0.75,
            ),
          ),
        ],
      ),
    );
  }
}

class HomeProductSkeleton extends StatelessWidget {
  const HomeProductSkeleton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MySkeletonCircle(
              height: 70,
              width: 70,
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
                    MySkeletonRectangle(
                      width: 200,
                      height: 20,
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    MySkeletonRectangle(
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
              child: MySkeletonRectangle(
                width: 65,
                height: 20,
              ),
            )
          ],
        ),
      ),
    );
  }
}
