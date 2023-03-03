class SignUpResponse {
  bool success;
  int errorCode;
  String message;
  SignUpData signUpData;

  SignUpResponse({
    required this.success,
    required this.errorCode,
    required this.message,
    required this.signUpData});

  factory SignUpResponse.fromJson(Map<String, dynamic> json) {
    return SignUpResponse(
      success: json['success'],
      errorCode: json['errorCode'],
      message: json['message'],
      signUpData: SignUpData.fromJson(json['data']),
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['success'] = success;
    data['errorCode'] = errorCode;
    data['message'] = message;
    if (data != null) {
      data['data'] = signUpData.toJson();
    }
    return data;
  }
}

class SignUpData {
  int memberId;
  String email;
  String name;
  String address;
  String token;

  SignUpData({
    required this.memberId,
    required this.email, required this.name,
    required this.address,
    required this.token});

  factory SignUpData.fromJson(Map<String, dynamic> json) {
    return SignUpData(
      memberId: json['memberId'],
      email: json['email'],
      name: json['name'],
      address: json['address'],
      token: json['token'],
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['memberId'] = memberId;
    data['email'] = email;
    data['name'] = name;
    data['address'] = address;
    data['token'] = token;
    return data;
  }
}
