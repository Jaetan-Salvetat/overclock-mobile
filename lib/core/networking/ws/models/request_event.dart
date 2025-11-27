class RequestEvent {
  final Header header;
  final Map<String, dynamic> data;

  RequestEvent({required this.header, required this.data});
}

class Header {
  final String type;
  final String token;

  Header({required this.type, required this.token});

  Map<String, dynamic> toJson() {
    return {'type': type, 'token': token};
  }
}
