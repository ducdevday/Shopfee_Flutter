part of home;

class HomeProduct extends StatelessWidget {
  final ProductInformationEntity product;
  final ProductViewType viewType;

  const HomeProduct({
    super.key,
    required this.product,
    required this.viewType,
  });

  @override
  Widget build(BuildContext context) {
    if (viewType == ProductViewType.List_View_Vertical) {
      return GestureDetector(
        onTap: () {
          NavigationUtil.pushNamed(ProductDetailPage.route,
              arguments: product.id);
        },
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                  vertical: 8.0, horizontal: AppDimen.screenPadding),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        height: 70,
                        width: 70,
                        decoration: const BoxDecoration(
                          color: Color(0xfff4f4f3),
                          shape: BoxShape.circle,
                          // image: DecorationImage(image: NetworkImage(product.imageUrl,),fit: BoxFit.cover)
                        ),
                      ),
                      Image.network(
                        product.imageUrl ?? "",
                        height: 68,
                        width: 58,
                      ),
                      Positioned(
                        bottom: 0,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.75),
                              borderRadius: BorderRadius.circular(10)),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.star_rounded,
                                color: Color(0xffFFB800),
                                size: 12,
                              ),
                              const SizedBox(
                                width: 2,
                              ),
                              Text(
                                "${product.ratingSummary?.quantity}",
                                style: const TextStyle(
                                    color: Color(0xff3C3C3C),
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 4.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(product.name!,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: AppStyle.mediumTextStyleDark
                                  .copyWith(color: const Color(0xff555555))),
                          const SizedBox(
                            height: 4,
                          ),
                          Text(product.description!,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: AppStyle.normalTextStyleDark
                                  .copyWith(color: const Color(0xff555555))),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 4.0),
                    child: Text(
                      FormatUtil.formatMoney(product.price),
                      style: AppStyle.mediumTextStyleDark
                          .copyWith(color: AppColor.headingColor),
                    ),
                  )
                ],
              ),
            ),
            if (product.status == ProductStatus.OUT_OF_STOCK)
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white
                        .withOpacity(0.4), // Adjust opacity and color as needed
                  ),
                ),
              ),
            if (product.status == ProductStatus.OUT_OF_STOCK)
              Image.asset(
                AppPath.imgSoldOut,
                width: 50,
                height: 50,
              ),
          ],
        ),
      );
    }
    else if (viewType == ProductViewType.List_View_Horizontal) {
      return GestureDetector(
        onTap: () {
          NavigationUtil.pushNamed(ProductDetailPage.route,
              arguments: product.id);
        },
        child: Card(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
              side: BorderSide(color: Color(0xfff5f5f5), width: 2)),
          elevation: 0.25,
          child: Center(
            child: Stack(
              children: [
                Container(
                  padding: const EdgeInsets.all(16.0),
                  width: MediaQuery.of(context).size.width / 3,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Stack(
                        children: [
                          Align(
                            alignment: Alignment.center,
                            child: Image.network(
                              product.imageUrl ?? "",
                              height: 88,
                              width: 68,
                            ),
                          ),
                          Positioned(
                            bottom: 8,
                            left: 0,
                            right: 0,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  padding:
                                  const EdgeInsets.symmetric(horizontal: 4),
                                  decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.75),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Row(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.center,
                                    children: [
                                      const Icon(
                                        Icons.star_rounded,
                                        color: Color(0xffFFB800),
                                        size: 12,
                                      ),
                                      const SizedBox(
                                        width: 2,
                                      ),
                                      Text(
                                        "${product.ratingSummary?.quantity}",
                                        style: const TextStyle(
                                            color: Color(0xff3C3C3C),
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(product.name ?? "",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AppStyle.mediumTextStyleDark.copyWith(
                                color: Color(0xff555555), height: 1.5)),
                      ),
                      SizedBox(height: 4,),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(FormatUtil.formatMoney(product.price),
                            style: AppStyle.mediumTextStyleDark.copyWith(
                                color: AppColor.headingColor, height: 1.2)),
                      ),
                    ],
                  ),
                ),
                if (product.status == ProductStatus.OUT_OF_STOCK)
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(
                            0.4), // Adjust opacity and color as needed
                      ),
                    ),
                  ),
                if (product.status == ProductStatus.OUT_OF_STOCK)
                  Image.asset(
                    AppPath.imgSoldOut,
                    width: 50,
                    height: 50,
                  ),
              ],
            ),
          ),
        ),
      );
    }
    else {
      return InkWell(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onTap: () {
          NavigationUtil.pushNamed(ProductDetailPage.route,
              arguments: product.id);
        },
        child: Card(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
              side: BorderSide(color: Color(0xfff5f5f5), width: 2)),
          elevation: 0.25,
          child: Center(
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Stack(
                        children: [
                          Align(
                            alignment: Alignment.center,
                            child: Image.network(
                              product.imageUrl ?? "",
                              height: 88,
                              width: 68,
                            ),
                          ),
                          Positioned(
                            bottom: 8,
                            left: 0,
                            right: 0,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 4),
                                  decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.75),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      const Icon(
                                        Icons.star_rounded,
                                        color: Color(0xffFFB800),
                                        size: 12,
                                      ),
                                      const SizedBox(
                                        width: 2,
                                      ),
                                      Text(
                                        "${product.ratingSummary?.quantity}",
                                        style: const TextStyle(
                                            color: Color(0xff3C3C3C),
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(product.name ?? "",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AppStyle.mediumTextStyleDark.copyWith(
                                color: Color(0xff555555), height: 1.5)),
                      ),
                      SizedBox(height: 4,),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(FormatUtil.formatMoney(product.price),
                            style: AppStyle.mediumTextStyleDark.copyWith(
                                color: AppColor.headingColor, height: 1.2)),
                      ),
                    ],
                  ),
                ),
                if (product.status == ProductStatus.OUT_OF_STOCK)
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(
                            0.4), // Adjust opacity and color as needed
                      ),
                    ),
                  ),
                if (product.status == ProductStatus.OUT_OF_STOCK)
                  Image.asset(
                    AppPath.imgSoldOut,
                    width: 50,
                    height: 50,
                  ),
              ],
            ),
          ),
        ),
      );
    }
  }
}
