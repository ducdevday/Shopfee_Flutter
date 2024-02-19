class MyToken{
  final String userId;
  final String accessToken;
  final String refreshToken;

  const MyToken({
    required this.userId,
    required this.accessToken,
    required this.refreshToken,
  });

  factory MyToken.fromJson(Map<String, dynamic> json) {
    return MyToken(
      userId: json["userId"],
      accessToken: json["accessToken"],
      refreshToken: json["refreshToken"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "employeeId": this.userId,
      "accessToken": this.accessToken,
      "refreshToken": this.refreshToken,
    };
  }
}