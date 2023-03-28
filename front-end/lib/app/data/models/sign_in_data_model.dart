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

class GoogleSignInData {
  String googleToken;
  String email;
  String name;
  String address;
  bool alreadyRegistered;

  GoogleSignInData(
      {required this.googleToken,
      required this.email,
      required this.name,
      required this.address,
      required this.alreadyRegistered});

  factory GoogleSignInData.fromJson(Map<String, dynamic> json) {
    return GoogleSignInData(
      googleToken: json['googleToken'],
      email: json['email'],
      name: json['name'],
      address: json['address'],
      alreadyRegistered: json['alreadyRegistered'],
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['googleToken'] = googleToken;
    data['email'] = email;
    data['name'] = name;
    data['address'] = address;
    data['alreadyRegistered'] = alreadyRegistered;
    return data;
  }
}
