part of store;
class StoreSkeleton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      padding: const EdgeInsets.all(AppDimen.spacing),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(AppDimen.smallRadius)),
      ),
      child: const Row(
        children: [
          ClipRRect(
            borderRadius:
            BorderRadius.all(Radius.circular(AppDimen.smallRadius)),
            child: MyShimmerRectangle(
              width: 90,
              height: 100,
            ),
          ),
          SizedBox(
            width: AppDimen.spacing,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MyShimmerRectangle(
                  width: 80,
                  height: 16,
                ),
                Spacer(),
                MyShimmerRectangle(
                  width: 100,
                  height: 14,
                ),
                SizedBox(height: 4,),
                MyShimmerRectangle(
                  width: 60,
                  height: 16,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}