class ReservationData {
  int voluntaryWorkId;
  int reservationId;
  int walkId;
  String startDate;
  String startTime;
  String endTime;
  String specificAddress;
  int maxPeopleNumber;
  int currentPeopleNumber;
  bool active;

  ReservationData(
      {required this.voluntaryWorkId,
      required this.reservationId,
      required this.walkId,
      required this.startDate,
      required this.startTime,
      required this.endTime,
      required this.specificAddress,
      required this.maxPeopleNumber,
      required this.currentPeopleNumber,
      required this.active});

  factory ReservationData.fromJson(Map<String, dynamic> json) {
    return ReservationData(
      voluntaryWorkId: json['voluntaryWorkId'],
      reservationId: json['reservationId'],
      walkId: json['walkId'],
      startDate: json['startDate'],
      startTime: json['startTime'],
      endTime: json['endTime'],
      specificAddress: json['specificAddress'],
      maxPeopleNumber: json['maxPeopleNumber'],
      currentPeopleNumber: json['currentPeopleNumber'],
      active: json['active'],
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['voluntaryWorkId'] = voluntaryWorkId;
    data['reservationId'] = reservationId;
    data['walkId'] = walkId;
    data['startDate'] = startDate;
    data['startTime'] = startTime;
    data['endTime'] = endTime;
    data['specificAddress'] = specificAddress;
    data['maxPeopleNumber'] = maxPeopleNumber;
    data['currentPeopleNumber'] = currentPeopleNumber;
    data['active'] = active;
    return data;
  }
}
