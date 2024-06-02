part of home;

class HomeBlog extends StatelessWidget {
  final BlogInformationEntity blog;

  const HomeBlog({super.key, required this.blog});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () {
        NavigationUtil.pushNamed(BlogDetailPage.route, arguments: blog.id);
      },
      child: Card(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
            side: BorderSide(color: Color(0xfff5f5f5), width: 2)),
        elevation: 0.25,
        child: SizedBox(
          width: 150,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(8.0),
                    topRight: Radius.circular(8.0)),
                child: CachedNetworkImage(
                  imageUrl: "${blog.thumbnailUrl}",
                  errorWidget: (_, __, ___) => Image.asset(
                    AppPath.imgImageError,
                    height: 88,
                    width: 68,
                  ),
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppDimen.smallSpacing),
                child: Column(
                  children: [
                    SizedBox(height: AppDimen.smallSpacing,),
                    Text(blog.title ?? "",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: AppStyle.mediumTextStyleDark
                            .copyWith(color: const Color(0xff555555))),
                    const SizedBox(
                      height: 4,
                    ),
                    Row(
                      children: [
                        Icon(Icons.calendar_month_rounded, size: AppDimen.xSmallSize,color: const Color(0xff555555),),
                        Expanded(
                          child: Text(FormatUtil.formatDate3(blog.createdAt),
                              style: AppStyle.normalTextStyleDark
                                  .copyWith(color: const Color(0xff555555))),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
