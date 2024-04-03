class MyToken{
  final String userId;
  final String accessToken;

  const MyToken({
    required this.userId,
    required this.accessToken,
  });

  factory MyToken.fromJson(Map<String, dynamic> json) {
    return MyToken(
      userId: json["userId"],
      accessToken: json["accessToken"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "userId": this.userId,
      "accessToken": this.accessToken,
    };
  }
}