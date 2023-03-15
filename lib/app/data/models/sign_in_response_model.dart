class SignInResponse {
  bool success;
  int errorCode;
  String message;
  SignInData? signInData;

  SignInResponse({
    required this.success,
    required this.errorCode,
    required this.message,
    required this.signInData});

  factory SignInResponse.fromJson(Map<String, dynamic> json) {
    return SignInResponse(
      success: json['success'],
      errorCode: json['errorCode'],
      message: json['message'],
      signInData: json['data'] != null
          ? SignInData.fromJson(json['data'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['success'] = success;
    data['errorCode'] = errorCode;
    data['message'] = message;
    data['data'] = signInData?.toJson();
    return data;
  }
}

class SignInData {
  int memberId;
  String token;

  SignInData({required this.memberId, required this.token});

  factory SignInData.fromJson(Map<String, dynamic> json) {
    return SignInData(
      memberId: json['memberId'],
      token: json['token'],
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['memberId'] = memberId;
    data['token'] = token;
    return data;
  }
}
