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
