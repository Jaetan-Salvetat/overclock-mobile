import 'package:overclock/core/networking/ws/models/request_type.dart';

class ResponseEvent {
  final RequestType type;
  final Map<String, dynamic> data;

  ResponseEvent({required this.type, required this.data});

  factory ResponseEvent.fromJson(Map<String, dynamic> json) {
    return ResponseEvent(
      type: RequestType.fromLabel(json['type']),
      data: json['data'],
    );
  }
}
