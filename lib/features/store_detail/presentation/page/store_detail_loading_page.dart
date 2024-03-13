part of store_detail;

class StoreDetailLoadingPage extends StatelessWidget {
  const StoreDetailLoadingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              children: [
                Lottie.asset(
                  AppPath.imhStoreLoading,
                  width: AppDimen.mediumImageSize,
                  height: AppDimen.mediumImageSize,
                ),
                Positioned(
                    bottom: AppDimen.spacing,
                    right: 0,
                    left: AppDimen.spacing,
                    child: Center(
                        child: Text(
                      "Loading...",
                      style: AppStyle.mediumTextStyleDark
                          .copyWith(color: AppColor.primaryColor),
                    )))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
