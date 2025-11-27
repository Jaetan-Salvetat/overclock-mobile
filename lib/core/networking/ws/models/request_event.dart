import 'package:overclock/core/networking/ws/models/request_type.dart';

class RequestEvent {
  final Header header;
  final Map<String, dynamic> data;

  RequestEvent({required this.header, required this.data});

  Map<String, dynamic> toJson() {
    return {'header': header.toJson(), 'data': data};
  }
}

class Header {
  final RequestType type;
  final String token;

  Header({required this.type, required this.token});

  Map<String, dynamic> toJson() {
    return {'type': type.label, 'token': token};
  }
}
