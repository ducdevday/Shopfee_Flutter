part of history;

class HistorySkeleton extends StatelessWidget {
  const HistorySkeleton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: 10,
      itemBuilder: (context, index) => Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: const Padding(
          padding: EdgeInsets.symmetric(horizontal: AppDimen.screenPadding),
          child: Row(children: [
            MySkeletonRectangle(
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
                  MySkeletonRectangle(
                    width: 100,
                    height: 20,
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  MySkeletonRectangle(
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
                MySkeletonRectangle(
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
      ),
      separatorBuilder: (context, index) => const Divider(
        height: 10,
        indent: AppDimen.screenPadding,
      ),
    );
  }
}
