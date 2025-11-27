class RequestLogin {
  final String key;

  RequestLogin({required this.key});

  Map<String, dynamic> toJson() => {'key': key};
}
