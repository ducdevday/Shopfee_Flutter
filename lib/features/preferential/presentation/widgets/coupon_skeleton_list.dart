part of preferential;

class CouponSkeletonList extends StatelessWidget {
  const CouponSkeletonList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        padding: EdgeInsets.only(
          top: AppDimen.spacing,),
        itemBuilder: (context, index) => CouponByTypeSkeleton(),
        separatorBuilder: (context, index) => SizedBox(
              height: AppDimen.spacing,
            ),
        itemCount: 8);
  }
}
