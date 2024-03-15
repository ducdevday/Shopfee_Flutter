part of store;

class StoreItem extends StatelessWidget {
  final StoreInformationEntity store;
  final String fromRoute;
  const StoreItem({super.key,
    required this.store, required this.fromRoute,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if(fromRoute != CartPage.route) {
          NavigationUtil.pushNamed(StoreDetailPage.route, arguments: store.id);
        }
        else{
          NavigationUtil.pop(result: store.id);
        }
      },
      child: Container(
        height: 100,
        padding: const EdgeInsets.all(AppDimen.spacing),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(AppDimen.smallRadius)),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius:
              const BorderRadius.all(Radius.circular(AppDimen.smallRadius)),
              child: Image.network(
                "${store.imageUrl}",
                fit: BoxFit.cover,
                width: 90,
                height: 100,
              ),
            ),
            const SizedBox(
              width: AppDimen.spacing,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${store.name}",
                    style: AppStyle.mediumTextStyleDark,
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on_outlined,
                        size: 16,
                      ),
                      Expanded(
                        child: Text(
                          "${store.fullAddress}",
                          style: AppStyle.smallTextStyleDark,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "${store.distance} away",
                    style: AppStyle.normalTextStyleDark,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}