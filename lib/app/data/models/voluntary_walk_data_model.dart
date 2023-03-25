class VoluntaryWalkData {
  int voluntaryWorkId;
  int walkId;
  String specialTheme;
  String institution;
  String specificAddress;

  VoluntaryWalkData(
      {required this.voluntaryWorkId,
        required this.walkId,
        required this.specialTheme,
        required this.institution,
        required this.specificAddress});

  factory VoluntaryWalkData.fromJson(Map<String, dynamic> json) {
    return VoluntaryWalkData(
      voluntaryWorkId: json['voluntaryWorkId'],
      walkId: json['walkId'],
      specialTheme: json['specialTheme'],
      institution: json['institution'],
      specificAddress: json['specificAddress'],
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['voluntaryWorkId'] = voluntaryWorkId;
    data['walkId'] = walkId;
    data['specialTheme'] = specialTheme;
    data['institution'] = institution;
    data['specificAddress'] = specificAddress;
    return data;
  }
}
