class NicknameCheckData {
  String inputName;
  bool duplicated;

  NicknameCheckData({
    required this.inputName,
    required this.duplicated,
  });

  factory NicknameCheckData.fromJson(Map<String, dynamic> json) {
    return NicknameCheckData(
      inputName: json['inputName'],
      duplicated: json['duplicated'],
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['inputName'] = inputName;
    data['duplicated'] = duplicated;
    return data;
  }
}
