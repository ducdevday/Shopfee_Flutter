part of product_detail;

class ProductImage extends StatefulWidget {
  const ProductImage({
    super.key,
  });

  @override
  State<ProductImage> createState() => _ProductImageState();
}

class _ProductImageState extends State<ProductImage> {
  bool seenToolTip = SharedService.getSeenTooltip();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductDetailBloc, ProductDetailState>(
      builder: (context, state) {
        if (state is ProductDetailLoadSuccess) {
          if (seenToolTip == false) {
            return OverlayTooltipItem(
              displayIndex: 0,
              tooltipHorizontalPosition: TooltipHorizontalPosition.CENTER,
              tooltip: (controller) {
                return Padding(
                  padding: const EdgeInsets.only(top: AppDimen.spacing),
                  child: MyTooltip(
                    title: 'Tap image to see in full screen',
                    controller: controller,
                    okCallBack: () {
                      SharedService.setSeenTooltip(true);
                    },
                  ),
                );
              },
              child: GestureDetector(
                onTap: () {
                  NavigationUtil.pushNamed(ImageFullScreen.route,
                      arguments: state.order.product.imageUrl!);
                },
                child: Hero(
                  tag: "Product",
                  child: CachedNetworkImage(
                    imageUrl: state.order.product.imageUrl!,
                    width: 165,
                    height: 270,
                    placeholder: (context, url) => MyPlaceHolderRectangle(
                      width: 165,
                      height: 270,
                    ),
                    errorWidget: (_, __, ___) => Image.asset(
                      AppPath.imgImageError,
                      width: AppDimen.largeSize,
                      height: AppDimen.largeSize,
                    ),
                  ),
                ),
              ),
            );
          } else {
            return GestureDetector(
              onTap: () {
                NavigationUtil.pushNamed(ImageFullScreen.route,
                    arguments: state.order.product.imageUrl!);
              },
              child: CachedNetworkImage(
                imageUrl: state.order.product.imageUrl!,
                width: 165,
                height: 270,
                placeholder: (context, url) => MyPlaceHolderRectangle(
                  width: 165,
                  height: 270,
                ),
                errorWidget: (_, __, ___) => Image.asset(
                  AppPath.imgImageError,
                  width: AppDimen.largeSize,
                  height: AppDimen.largeSize,
                ),
              ),
            );
          }
        } else {
          return SizedBox();
        }
      },
    );
  }
}
