part of onboarding;

class OnBoardingPage2 extends StatelessWidget {
  const OnBoardingPage2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      AppPath.imgOnBoarding2,
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      fit: BoxFit.fill,
      scale: 1,
    );
  }
}
