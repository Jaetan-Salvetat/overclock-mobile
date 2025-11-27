class ResponseError {
  final bool success;
  final String data;

  ResponseError({required this.success, required this.data});

  factory ResponseError.fromJson(Map<String, dynamic> json) =>
      ResponseError(success: json['success'], data: json['data']);

  static bool isAnError(Map<String, dynamic> json) => json['success'] == false;
}
