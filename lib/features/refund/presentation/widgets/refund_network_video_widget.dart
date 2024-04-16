part of refund;

class RefundNetworkVideoWidget extends StatefulWidget {
  final String url;

  const RefundNetworkVideoWidget({super.key, required this.url});

  @override
  State<RefundNetworkVideoWidget> createState() =>
      _RefundNetworkVideoWidgetState();
}

class _RefundNetworkVideoWidgetState extends State<RefundNetworkVideoWidget> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.networkUrl(Uri.parse(widget.url))
      ..initialize().then((_) {
        setState(() {}); //when your thumbnail will show.
      });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 4,
      height: MediaQuery.of(context).size.width / 4,
      decoration: BoxDecoration(
          color: AppColor.greyColor,
          borderRadius: BorderRadius.all(Radius.circular(12))),
      child: Stack(
        children: [
          GestureDetector(
              onTap: () {
                NavigationUtil.pushNamed(NetworkVideoFullScreen.route,
                    arguments: widget.url);
              },
              child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                  child: VideoPlayer(_controller))),
          Positioned(
            bottom: 0,
            child: Container(
              padding: EdgeInsets.all(4),
              decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.7),
                  shape: BoxShape.rectangle,
                  borderRadius:
                      BorderRadius.only(bottomLeft: Radius.circular(12))),
              child: Text(
                FormatUtil.formatSeconds(_controller.value.duration.inSeconds),
                style: AppStyle.normalTextStyle,
              ),
            ),
          )
        ],
      ),
    );
  }
}
