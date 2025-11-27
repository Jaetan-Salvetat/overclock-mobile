class ResponseEvent {
  final String type;
  final Map<String, dynamic> data;

  ResponseEvent({required this.type, required this.data});

  factory ResponseEvent.fromJson(Map<String, dynamic> json) {
    return ResponseEvent(type: json['type'], data: json['data']);
  }
}
