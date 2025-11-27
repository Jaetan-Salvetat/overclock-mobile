class ResponseLogin {
  final String token;

  ResponseLogin({required this.token});

  factory ResponseLogin.fromJson(Map<String, dynamic> json) {
    return ResponseLogin(token: json['token']);
  }
}
