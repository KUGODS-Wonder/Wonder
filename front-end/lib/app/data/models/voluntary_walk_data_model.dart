class VoluntaryWalkData {
  int voluntaryWorkId;
  int walkId;
  String specialTheme;
  String institution;
  String specificAddress;
  String startDate;
  String startTime;
  String endTime;

  VoluntaryWalkData(
      {required this.voluntaryWorkId,
        required this.walkId,
        required this.specialTheme,
        required this.institution,
        required this.specificAddress,
        required this.startDate,
        required this.startTime,
        required this.endTime});

  factory VoluntaryWalkData.fromJson(Map<String, dynamic> json) {
    return VoluntaryWalkData(
      voluntaryWorkId: json['voluntaryWorkId'],
      walkId: json['walkId'],
      specialTheme: json['specialTheme'],
      institution: json['institution'],
      specificAddress: json['specificAddress'],
      startDate: json['startDate'],
      startTime: json['startTime'],
      endTime: json['endTime'],
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['voluntaryWorkId'] = voluntaryWorkId;
    data['walkId'] = walkId;
    data['specialTheme'] = specialTheme;
    data['institution'] = institution;
    data['specificAddress'] = specificAddress;
    data['startDate'] = startDate;
    data['startTime'] = startTime;
    data['endTime'] = endTime;
    return data;
  }
}
