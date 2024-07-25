part of blog;

class BlogPage extends StatefulWidget {
  static const String route = "/blog";

  const BlogPage({Key? key}) : super(key: key);

  @override
  State<BlogPage> createState() => _BlogPageState();
}

class _BlogPageState extends State<BlogPage> {
  late final BlogBloc _bloc;

  int initPage = 1;
  int initSize = 8;
  late bool isLoadingMore;
  late bool cannotLoadMore;
  late List<BlogInformationEntity> blogList;
  late ScrollController scrollController;
  late final RefreshController _refreshController;

  @override
  void initState() {
    super.initState();
    _bloc = ServiceLocator.sl<BlogBloc>();
    _bloc.add(BlogLoadInformation(initPage: initPage, initSize: initSize));
    scrollController = ScrollController();
    scrollController.addListener(_scrollListener);
    _refreshController = RefreshController(initialRefresh: false);
  }

  @override
  void dispose() {
    _bloc.close();
    scrollController.dispose();
    _refreshController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (isLoadingMore || cannotLoadMore) return;
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      _bloc.add(BlogLoadMoreInformation());
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _bloc,
      child: BlocListener<BlogBloc, BlogState>(
        listener: (context, state) {
          if (state is BlogLoadSuccess) {
            isLoadingMore = state.isLoadMore;
            cannotLoadMore = state.cannotLoadMore;
            blogList = state.blogs;
          }
        },
        child: RefreshConfiguration.copyAncestor(
          context: context,
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
              title: Text(
                R.allBlogs.tr(),
                style: AppStyle.largeTitleStyleDark,
              ),
              centerTitle: true,
              bottom: const PreferredSize(
                preferredSize: Size.fromHeight(1),
                child: Divider(height: 1),
              ),
            ),
            body: Column(
              children: [
                BlocBuilder<BlogBloc, BlogState>(
                  builder: (context, state) {
                    if (state is BlogLoadInProcess) {
                      return Expanded(
                        child: Center(
                          child: CupertinoActivityIndicator(),
                        ),
                      );
                    } else if (state is BlogLoadSuccess) {
                      if (blogList.isNotEmpty) {
                        return Expanded(
                          child: SmartRefresher(
                            controller: _refreshController,
                            enablePullUp: !cannotLoadMore,
                            physics: BouncingScrollPhysics(),
                            onRefresh: () async {
                              context.read<BlogBloc>().add(
                                  BlogRefreshInformation(
                                      initPage: initPage, initSize: initSize));
                              _refreshController.refreshCompleted();
                            },
                            child: GridView.builder(
                                controller: scrollController,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 4.0,
                                  mainAxisSpacing: 4.0,
                                  childAspectRatio: 2 / 3,
                                ),
                                itemCount: blogList.length,
                                itemBuilder: (context, index) =>
                                    BlogInformationItem(blog: blogList[index])),
                          ),
                        );
                      } else {
                        return Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                AppPath.icNoBlog,
                                width: 60,
                                height: 60,
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              Text(
                                R.noBlogFound.tr(),
                                style: AppStyle.mediumTextStyleDark
                                    .copyWith(color: AppColor.nonactiveColor),
                              )
                            ],
                          ),
                        );
                      }
                    } else {
                      return const SizedBox();
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
