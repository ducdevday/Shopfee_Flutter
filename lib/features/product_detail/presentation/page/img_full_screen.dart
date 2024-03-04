part of product_detail;

class ImageFullScreen extends StatelessWidget {
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
          child: CachedNetworkImage(
            imageUrl: imgPath,
            placeholder: (context, url) => const MySkeletonRectangle(
                width: double.infinity, height: double.infinity),
            errorWidget: (_, __, ___) => Container(
                color: AppColor.unLikedColor,
                child: const Icon(
                  Icons.error_outline_rounded,
                  color: Colors.red,
                  size: AppDimen.largeSize,
                )),
          ),
        ),
        Positioned(
          top: AppDimen.headerMargin,
          left: AppDimen.screenPadding,
          child: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.close, size: 20),
            style: IconButton.styleFrom(
              backgroundColor: Colors.white,
              padding: const EdgeInsets.all(8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14.0),
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
