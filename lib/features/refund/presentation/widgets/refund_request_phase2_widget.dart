part of refund;

class RefundRequestPhase2Widget extends StatefulWidget {
  final String orderId;
  const RefundRequestPhase2Widget({super.key, required this.orderId});

  @override
  State<RefundRequestPhase2Widget> createState() =>
      _RefundRequestPhase2WidgetState();
}

class _RefundRequestPhase2WidgetState extends State<RefundRequestPhase2Widget> {
  late final RefundBloc _bloc;
  late final TextEditingController textEditingController;

  @override
  void initState() {
    super.initState();
    _bloc = context.read<RefundBloc>();
    textEditingController = TextEditingController();
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  void handlePickImageOrVideo(int currentMediasLength) async {
    try {
      if(currentMediasLength == 6) return;
      final List<XFile> medias = await ImagePicker().pickMultipleMedia();
      if (medias.isNotEmpty) {
        _bloc.add(RefundChooseMultipleMedia(chosenMediaList: medias));
      }
    } catch (e) {
      print(e);
    }
  }

  Widget buildMediaWidget(File? file) {
    if (file == null) return SizedBox();
    final mediaType = MediaTypeExtension.determineMediaTypeFromPath(file.path);
    switch (mediaType) {
      case MediaType.IMAGE:
        return RefundLocalImageWidget(image: file);
      case MediaType.VIDEO:
        return RefundLocalVideoWidget(video: file);
      default:
        return SizedBox();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RefundBloc, RefundState>(
      builder: (context, state) {
        if (state is RefundRequestPhase2State) {
          textEditingController.text = state.note;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        R.whatProblem.tr(),
                        style: AppStyle.mediumTextStyleDark,
                      ),
                      SizedBox(
                        height: AppDimen.smallPadding,
                      ),
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                state.reasonRefundType.getString(),
                                style: AppStyle.normalTextStyleDark,
                              ),
                              InkWell(
                                  onTap: () {
                                    context.read<RefundBloc>().add(
                                        RefundSetNote(
                                            note: textEditingController.text));
                                    context.read<RefundBloc>().add(
                                        RefundChooseReasonPressed(
                                            reasonRefundType:
                                                state.reasonRefundType));
                                  },
                                  child: Icon(Icons.arrow_forward_rounded))
                            ],
                          ),
                          Divider(),
                        ],
                      ),
                      SizedBox(
                        height: AppDimen.smallPadding,
                      ),
                      Text(
                        "${R.updloadImageOrVideo.tr()} (required)",
                        style: AppStyle.mediumTextStyleDark,
                      ),
                      SizedBox(
                        height: AppDimen.smallPadding,
                      ),
                      Wrap(
                        spacing: AppDimen.spacing,
                        runSpacing: AppDimen.spacing,
                        children: [
                          ...state.mediaList.map((e) => buildMediaWidget(e)),
                          GestureDetector(
                            onTap: () {
                              handlePickImageOrVideo(state.mediaList.length);
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width / 4,
                              height: MediaQuery.of(context).size.width / 4,
                              decoration: BoxDecoration(
                                  color: AppColor.greyColor,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12))),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.photo_camera_outlined),
                                  Text("${state.mediaList.length}/6")
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: AppDimen.smallPadding,
                      ),
                      Text(
                        R.addOpinionNote.tr(),
                        style: AppStyle.mediumTextStyleDark,
                      ),
                      SizedBox(
                        height: AppDimen.spacing,
                      ),
                      TextFormField(
                        textInputAction: TextInputAction.next,
                        controller: textEditingController,
                        decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 12),
                            focusedErrorBorder:
                                AppStyle.outlineInputBorderDefault,
                            errorBorder: AppStyle.outlineInputBorderDefault,
                            enabledBorder: AppStyle.outlineInputBorderDefault,
                            focusedBorder: AppStyle.outlineInputBorderPrimary,
                            disabledBorder: AppStyle.outlineInputBorderDefault,
                            hintText: R.typeSomeText.tr(),
                            hintStyle: TextStyle(color: Colors.grey)),
                      ),
                    ],
                  ),
                ),
              ),
              Text(
                "* ${R.condiderRefund.tr()}",
                style: AppStyle.smallTextStyleDark,
              ),
              SizedBox(
                height: AppDimen.spacing,
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: state.mediaList.isEmpty ? null : () {
                    context.read<RefundBloc>().add(RefundCreateRequestPressed(orderId: widget.orderId, note: textEditingController.text.trim()));
                  },
                  child: Text(R.createRequest.tr()),
                  style: AppStyle.elevatedButtonStyleRed,
                ),
              )
            ],
          );
        }
        return SizedBox();
      },
    );
  }
}
