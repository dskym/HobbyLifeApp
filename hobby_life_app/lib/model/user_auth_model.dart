class UserAuthModel {
  final String accessToken;
  final String refreshToken;

  UserAuthModel({required this.accessToken, required this.refreshToken});

  factory UserAuthModel.fromJson(Map<String, dynamic> json) {
    return UserAuthModel(
      accessToken: json['accessToken'],
      refreshToken: json['refreshToken'],
    );
  }
}