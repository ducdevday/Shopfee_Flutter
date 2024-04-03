part of product_detail;

class ImageFullScreen extends StatelessWidget {
  static const String route = "/img_full_screen";
  final String imgPath;

  const ImageFullScreen({
    required this.imgPath,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(children: [
        Center(
          child: Hero(
            tag: "Product",
            child: CachedNetworkImage(
              imageUrl: imgPath,
              errorWidget: (_, __, ___) => Container(
                  color: AppColor.unLikedColor,
                  child: const Icon(
                    Icons.error_outline_rounded,
                    color: Colors.red,
                    size: AppDimen.largeSize,
                  )),
            ),
          ),
        ),
        Positioned(
          top: AppDimen.headerMargin,
          left: AppDimen.screenPadding,
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Hero(
              tag: "close_button",
              child: Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: AppColor.disableColor,
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    iconSize: 16,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.close_rounded,
                      color: Colors.white,
                    ),
                  )),
            ),
          ),
        ),
      ]),
    );
  }
}
