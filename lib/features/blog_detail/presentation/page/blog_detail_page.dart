part of blog_detail;

class BlogDetailPage extends StatefulWidget {
  static const String route = "/blog_detail";
  final String blogId;

  const BlogDetailPage({Key? key, required this.blogId}) : super(key: key);

  @override
  State<BlogDetailPage> createState() => _BlogDetailPageState();
}

class _BlogDetailPageState extends State<BlogDetailPage> {
  late final BlogDetailCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = ServiceLocator.sl<BlogDetailCubit>()
      ..loadBlogDetail(widget.blogId);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _cubit,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            icon: const Icon(Icons.close_rounded),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: BlocBuilder<BlogDetailCubit, BlogDetailState>(
            builder: (context, state) {
              if (state is BlogDetailLoadSuccess) {
                return Text(
                  state.blog.title,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                );
              }
              return SizedBox();
            },
          ),
          actions: [
            SizedBox(
              width: AppDimen.smallSize,
            )
          ],
          centerTitle: true,
          bottom: const PreferredSize(
            preferredSize: Size.fromHeight(1),
            child: Divider(height: 1),
          ),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                BlocBuilder<BlogDetailCubit, BlogDetailState>(
                  builder: (context, state) {
                    if (state is BlogDetailLoadInProcess) {
                      return CupertinoActivityIndicator();
                    } else if (state is BlogDetailLoadSuccess) {
                      return Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(AppDimen.screenPadding),
                            child: Text(
                              state.blog.title,
                              style: AppStyle.largeTitleStyleDark,
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Padding(
                              padding: const EdgeInsets.only(right: AppDimen.screenPadding, bottom: AppDimen.spacing),
                              child: Text(
                                FormatUtil.formatDate(state.blog.createdAt),
                                style: AppStyle.normalTextStyleDark,
                                textAlign: TextAlign.end,
                              ),
                            ),
                          ),
                          CachedNetworkImage(
                            imageUrl: state.blog.imageUrl,
                            height: MediaQuery.of(context).size.height / 4,
                            width: MediaQuery.of(context).size.width ,
                            fit: BoxFit.cover,
                            placeholder: (context, url) => MyPlaceHolderRectangle(
                              width: MediaQuery.of(context).size.width - 20,
                              height: 270,
                            ),
                            errorWidget: (_, __, ___) => Image.asset(
                                AppPath.imgImageError,
                                width: MediaQuery.of(context).size.width - 20),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: AppDimen.spacing,
                                horizontal: AppDimen.screenPadding),
                            child: HtmlWidget(
                              '''${state.blog.content}''',
                            ),
                          )
                        ],
                      );
                    } else {
                      return const MyErrorWidget();
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
