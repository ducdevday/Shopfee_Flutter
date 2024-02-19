part of history;

class HistoryNotAuthWidget extends StatelessWidget {
  const HistoryNotAuthWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(width: 1, color: AppColor.primaryColor)),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: SvgPicture.asset(
                AppPath.icShoppingBag,
                width: 120,
                height: 120,
                color: AppColor.primaryColor,
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            "Order & History",
            style: AppStyle.largeTitleStyleDark,
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            "Follow order and history of you",
            style: AppStyle.mediumTextStyleDark,
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.all(AppDimen.screenPadding),
            child: ElevatedButton(
              onPressed: () {
                NavigationUtil.pushNamed(LoginPage.route);
              },
              child: const Text("Register / Log in"),
              style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                  disabledBackgroundColor: const Color(0xffCACACA),
                  disabledForegroundColor: AppColor.lightColor,
                  textStyle: AppStyle.mediumTextStyleDark,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
