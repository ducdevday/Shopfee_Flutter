part of splash;

class SplashPage extends StatefulWidget {
  static const String route = "/splash";

  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 3000), () {
      if (SharedService.getIsFirstTime()) {
        NavigationUtil.pushNamedAndRemoveUntil(OnBoardingPage.route);
      } else if (SharedService.getUserId() != null) {
        NavigationUtil.pushNamedAndRemoveUntil( DefaultPage.route);
        // NavigationUtil.pushNamedAndRemoveUntil(ReceiptPage.route,
        //     arguments: "OB000000002");
      } else {
        NavigationUtil.pushNamedAndRemoveUntil(LoginPage.route);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Change to your desired background color
      body: Stack(
        children: [
          Center(
            child: Image.asset(
              AppPath.imgLogo1, // Path to your image
              width: 274, // Adjust the image size as needed
              height: 202,
            ),
          ),
          Center(
              child: Container(
                  margin: EdgeInsets.only(top: 400),
                  child:
                      CircularProgressIndicator())), // Circular Progress Indicator
        ],
      ),
    );
  }
}
