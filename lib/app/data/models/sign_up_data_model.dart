class SignUpData {
  int memberId;
  String email;
  String name;
  String address;
  String token;

  SignUpData(
      {required this.memberId,
      required this.email,
      required this.name,
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
