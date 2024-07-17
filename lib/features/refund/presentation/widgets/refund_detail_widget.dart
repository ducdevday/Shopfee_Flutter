part of refund;

class RefundDetailWidget extends StatelessWidget {
  const RefundDetailWidget({super.key});

  Widget buildMediaWidget(RefundMediaEntity media) {
    if (media.mediaType == MediaType.VIDEO) {
      return RefundNetworkVideoWidget(url: media.url!);
    } else {
      return RefundNetworkImageWidget(url: media.url!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RefundBloc, RefundState>(
      builder: (context, state) {
        if (state is RefundLoadDetailSuccessState) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RefundStatusWidget(status: state.refundDetail.status),
                      SizedBox(
                        height: AppDimen.smallPadding,
                      ),
                      Text(
                        R.problemWithOrder.tr(),
                        style: AppStyle.mediumTextStyleDark,
                      ),
                      SizedBox(
                        height: AppDimen.smallPadding,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${state.refundDetail.reason}",
                            style: AppStyle.normalTextStyleDark,
                          ),
                          Divider(),
                        ],
                      ),
                      SizedBox(
                        height: AppDimen.smallPadding,
                      ),
                      Text(
                        R.updloadImageOrVideo.tr(),
                        style: AppStyle.mediumTextStyleDark,
                      ),
                      SizedBox(
                        height: AppDimen.smallPadding,
                      ),
                      Wrap(
                        spacing: AppDimen.spacing,
                        runSpacing: AppDimen.spacing,
                        children: [
                          ...?state.refundDetail.mediaList
                              ?.map((e) => buildMediaWidget(e)),
                        ],
                      ),
                      SizedBox(
                        height: AppDimen.smallPadding,
                      ),
                      Text(
                        R.note.tr(),
                        style: AppStyle.mediumTextStyleDark,
                      ),
                      SizedBox(
                        height: AppDimen.spacing,
                      ),
                      TextFormField(
                        textInputAction: TextInputAction.next,
                        initialValue: state.refundDetail.note,
                        enabled: false,
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
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    NavigationUtil.pop();
                  },
                  child: Text(R.goBack.tr()),
                  style: AppStyle.elevatedButtonStylePrimary,
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
