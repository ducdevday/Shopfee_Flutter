part of refund;

class RefundLocalVideoWidget extends StatefulWidget {
  final File video;

  const RefundLocalVideoWidget({super.key, required this.video});

  @override
  State<RefundLocalVideoWidget> createState() => _RefundLocalVideoWidgetState();
}

class _RefundLocalVideoWidgetState extends State<RefundLocalVideoWidget> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.file(widget.video)
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
                NavigationUtil.pushNamed(LocalVideoFullScreen.route,
                    arguments: widget.video);
              },
              child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                  child: VideoPlayer(_controller))),
          Positioned(
            right: 0,
            child: GestureDetector(
              onTap: () {
                context
                    .read<RefundBloc>()
                    .add(RefundRemoveMedia(chosenMedia: widget.video));
              },
              child: Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.7),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.close_rounded,
                    color: Colors.white,
                    size: 16,
                  )),
            ),
          ),
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
