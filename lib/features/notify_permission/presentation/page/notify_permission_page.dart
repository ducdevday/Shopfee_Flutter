part of notify_permission;

class NotifyPermissionPage extends StatefulWidget {
  static const String route = "/notify_permission";
  final bool? fromAccount;

  const NotifyPermissionPage({Key? key, this.fromAccount = false})
      : super(key: key);

  @override
  State<NotifyPermissionPage> createState() => _NotifyPermissionPageState();
}

class _NotifyPermissionPageState extends State<NotifyPermissionPage> {
  late NotificationPermissionCubit _cubit;

  ValueNotifier<bool> isGrantedNotification = ValueNotifier(false);
  ValueNotifier<bool> isGrantedLocation = ValueNotifier(false);

  @override
  void initState() {
    super.initState();
    _cubit = ServiceLocator.sl<NotificationPermissionCubit>()
      ..saveFCMTokenToDB();
    if (widget.fromAccount!= null && widget.fromAccount == true) {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        handleRequestNotification();
        handleRequestLocation();
      });
    }
  }

  void handleRequestNotification() async {
    isGrantedNotification.value =
        await PushNotificationService.requestPermission();
    if (!isGrantedNotification.value) {
      AlertUtil.showToast("You denied notification");
    }
  }

  void handleRequestLocation() async {
    isGrantedLocation.value = await PermissionUtil.requestLocationPermission();
    if (!isGrantedLocation.value) {
      AlertUtil.showToast("You denied location");
    }
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
                    "Permission",
                    style: AppStyle.largeTitleStyleDark,
                  ),
                  const SizedBox(
                    height: AppDimen.spacing,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.all(AppDimen.spacing),
                    margin: const EdgeInsets.symmetric(
                        horizontal: AppDimen.screenPadding * 2),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.grey),
                    ),
                    child: ValueListenableBuilder(
                      valueListenable: isGrantedNotification,
                      builder: (BuildContext context,
                          bool grantedNotificationValue, Widget? child) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Turn On Notification",
                              style: AppStyle.normalTextStyleDark,
                            ),
                            SizedBox(
                              height: AppDimen.smallSize,
                              child: FittedBox(
                                fit: BoxFit.fill,
                                child: CupertinoSwitch(
                                  activeColor: AppColor.primaryColor,
                                  value: grantedNotificationValue,
                                  onChanged: grantedNotificationValue == true
                                      ? null
                                      : (bool value) {
                                          handleRequestNotification();
                                        },
                                ),
                              ),
                            )
                          ],
                        );
                      },
                    ),
                  ),
                  const SizedBox(
                    height: AppDimen.spacing,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.all(AppDimen.spacing),
                    margin: const EdgeInsets.symmetric(
                        horizontal: AppDimen.screenPadding * 2),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.grey),
                    ),
                    child: ValueListenableBuilder(
                      valueListenable: isGrantedLocation,
                      builder: (BuildContext context, bool grantedLocationValue,
                          Widget? child) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Turn On Location",
                              style: AppStyle.normalTextStyleDark,
                            ),
                            SizedBox(
                              height: AppDimen.smallSize,
                              child: FittedBox(
                                fit: BoxFit.fill,
                                child: CupertinoSwitch(
                                  activeColor: AppColor.primaryColor,
                                  value: grantedLocationValue,
                                  onChanged: grantedLocationValue == true
                                      ? null
                                      : (bool value) {
                                          handleRequestLocation();
                                        },
                                ),
                              ),
                            )
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: AppDimen.spacing,
              child: Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.symmetric(
                        horizontal: AppDimen.screenPadding),
                    child: ElevatedButton(
                        onPressed: () {
                          if (widget.fromAccount!= null && widget.fromAccount == true) {
                            NavigationUtil.pop();
                          } else {
                            NavigationUtil.pushNamedAndRemoveUntil(
                                LoginPage.route);
                          }
                        },
                        style: AppStyle.elevatedButtonStylePrimary,
                        child: Text(widget.fromAccount!= null && widget.fromAccount == true ? "Back" : "Continue")),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
