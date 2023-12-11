class GlobalData{
  static final ins = GlobalData._();
  GlobalData._();

  String? userId;
  String? accessToken;
  String? refreshToken;
  String? fcmToken;
  bool isFirstTime = true;

  final List<String> imgList = [
    'https://firebasestorage.googleapis.com/v0/b/shopfee-12b03.appspot.com/o/sample%2Fslide1.png?alt=media&token=fe374151-ece4-44df-a12b-4b8d0386fdbd',
    'https://firebasestorage.googleapis.com/v0/b/shopfee-12b03.appspot.com/o/sample%2Fslide2.png?alt=media&token=1a52560b-a9f8-4ae8-b569-a80511a8dbc2',
    'https://firebasestorage.googleapis.com/v0/b/shopfee-12b03.appspot.com/o/sample%2Fslide3.png?alt=media&token=6c1005ee-7d60-4ae8-b904-faadbd965b79',
  ];

}