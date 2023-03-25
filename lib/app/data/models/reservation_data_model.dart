class ReservationData {
  int voluntaryWorkId;
  int walkId;
  String startDate;
  String description;
  String specificAddress;
  int maxPeopleNumber;
  int currentPeopleNumber;
  bool active;

  ReservationData(
      {required this.voluntaryWorkId,
      required this.walkId,
      required this.startDate,
      required this.description,
      required this.specificAddress,
      required this.maxPeopleNumber,
      required this.currentPeopleNumber,
      required this.active});

  factory ReservationData.fromJson(Map<String, dynamic> json) {
    return ReservationData(
      voluntaryWorkId: json['voluntaryWorkId'],
      walkId: json['walkId'],
      startDate: json['startDate'],
      description: json['description'],
      specificAddress: json['specificAddress'],
      maxPeopleNumber: json['maxPeopleNumber'],
      currentPeopleNumber: json['currentPeopleNumber'],
      active: json['active'],
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['voluntaryWorkId'] = voluntaryWorkId;
    data['walkId'] = walkId;
    data['startDate'] = startDate;
    data['description'] = description;
    data['specificAddress'] = specificAddress;
    data['maxPeopleNumber'] = maxPeopleNumber;
    data['currentPeopleNumber'] = currentPeopleNumber;
    data['active'] = active;
    return data;
  }
}
