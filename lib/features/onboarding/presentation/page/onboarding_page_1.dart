part of onboarding;

class OnBoardingScreen1 extends StatelessWidget {
  const OnBoardingScreen1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      AppPath.imgOnBoarding1,
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      fit: BoxFit.fill,
      scale: 1,
    );
  }
}
