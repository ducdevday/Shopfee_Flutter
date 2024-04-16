part of refund;

class RefundNetworkImageWidget extends StatelessWidget {
  final String url;

  const RefundNetworkImageWidget({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 4,
      height: MediaQuery.of(context).size.width / 4,
      child: Stack(
        fit: StackFit.expand,
        children: [
          GestureDetector(
            onTap: () {
              NavigationUtil.pushNamed(NetworkImageFullScreen.route,
                  arguments: url);
            },
            child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(12)),
                child: Hero(
                  tag: "IMG",
                  child: CachedNetworkImage(
                    imageUrl: url,
                    fit: BoxFit.cover,
                    errorWidget: (_, __, ___) => Container(
                        color: AppColor.unLikedColor,
                        child: const Icon(
                          Icons.error_outline_rounded,
                          color: Colors.red,
                          size: AppDimen.largeSize,
                        )),
                  ),
                )),
          ),
        ],
      ),
    );
  }
}
