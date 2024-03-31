part of notify_permission;

class NotifyPermissionPage extends StatefulWidget {
  static const String route = "/notify_permission";

  const NotifyPermissionPage({Key? key}) : super(key: key);

  @override
  State<NotifyPermissionPage> createState() => _NotifyPermissionPageState();
}

class _NotifyPermissionPageState extends State<NotifyPermissionPage> {
  late NotificationPermissionCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = ServiceLocator.sl<NotificationPermissionCubit>()
      ..saveFCMTokenToDB();
  }

  void handleRequestPermission() async {
    bool isGrantedNotification =
        await PushNotificationService.requestPermission();
    if (isGrantedNotification) {
      print("User granted permission");
      NavigationUtil.pushNamed(LoginPage.route);
    } else {
      print("User denied permission");
      AlertUtil.showToast("You denied permission");
    }
  }

  void handleNotAllowNotify() {
    NavigationUtil.pushNamed(LoginPage.route);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _cubit,
      child: Scaffold(
        body: Stack(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    AppPath.imgNotifyPermission,
                    width: 250,
                    height: 250,
                  ),
                  const SizedBox(
                    height: AppDimen.spacing,
                  ),
                  Text(
                    "Notify",
                    style: AppStyle.largeTitleStyleDark,
                  ),
                  const SizedBox(
                    height: AppDimen.spacing,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 60.0),
                    child: Text(
                      "Please turn on notifications on the app to receive our notifications",
                      style: AppStyle.mediumTextStyleDark,
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              child: Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.symmetric(horizontal: AppDimen.screenPadding),
                    child: ElevatedButton(
                        onPressed: () {
                          handleRequestPermission();
                        },
                        child: const Text("Turn on"),
                        style: AppStyle.elevatedButtonStylePrimary),
                  ),
                  SizedBox(height: AppDimen.spacing,),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.symmetric(horizontal: AppDimen.screenPadding),
                    child: ElevatedButton(
                        onPressed: () {
                          handleNotAllowNotify();
                        },
                        child: const Text("Maybe later"),
                        style: AppStyle.elevatedButtonStyleSecondary),
                  ),
                  SizedBox(height: AppDimen.screenPadding,)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
