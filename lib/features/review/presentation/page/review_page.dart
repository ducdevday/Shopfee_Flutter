part of review;

class ReviewPage extends StatefulWidget {
  static const String route = "/review";
  final String orderId;

  const ReviewPage({
    Key? key,
    required this.orderId,
  }) : super(key: key);

  @override
  State<ReviewPage> createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  late final ReviewBloc _bloc;
  bool haveChanged = false;

  @override
  void initState() {
    super.initState();
    _bloc = ServiceLocator.sl<ReviewBloc>()
      ..add(ReviewLoadInformation(orderId: widget.orderId));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _bloc,
      child: BlocListener<ReviewBloc, ReviewState>(
        listener: (context, state) {
          if (state is ReviewLoadSuccess) {
            haveChanged = state.haveChanged;
          }
        },
        child: PopScope(
          canPop: false,
          onPopInvoked: (bool didPop) {
            if (didPop) {
              return;
            }
            NavigationUtil.pop(result: haveChanged);
          },
          child: Scaffold(
            backgroundColor: AppColor.scaffoldColorBackground,
            appBar: AppBar(
                backgroundColor: Colors.white,
                title: const Text("Review Order"),
                centerTitle: true,
                bottom: const PreferredSize(
                  preferredSize: Size.fromHeight(1),
                  child: Divider(height: 1),
                )),
            body: Padding(
              padding: const EdgeInsets.all(AppDimen.spacing),
              child: BlocBuilder<ReviewBloc, ReviewState>(
                builder: (context, state) {
                  switch (state) {
                    case ReviewLoadInProcess():
                      return const Center(
                        child: CupertinoActivityIndicator(),
                      );
                    case ReviewLoadSuccess():
                      return const ReviewInformationList();
                    case ReviewLoadFailure():
                      return const MyErrorWidget();
                    default:
                      return const SizedBox();
                  }
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
