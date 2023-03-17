class HttpResponse {
  bool success;
  int errorCode;
  String message;
  dynamic data;

  HttpResponse({
    required this.success,
    required this.errorCode,
    required this.message,
    this.data});

  factory HttpResponse.fromJson(Map<String, dynamic> json) {
    return HttpResponse(
      success: json['success'],
      errorCode: json['errorCode'],
      message: json['message'],
      data: json['data'] ??= json['data']
    );
  }
}