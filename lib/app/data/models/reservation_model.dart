class Reservation {
  String date;
  String timeStart;
  String timeEnd;
  String location;
  int maxPeopleCount;
  int appliedPeopleCount;

  Reservation({
    required this.date,
    required this.timeStart,
    required this.timeEnd,
    required this.location,
    required this.maxPeopleCount,
    required this.appliedPeopleCount,
  });

  factory Reservation.fromJson(Map<String, dynamic> json) {
    return Reservation(
      date: json['date'],
      timeStart: json['timeStart'],
      timeEnd: json['timeEnd'],
      location: json['location'],
      maxPeopleCount: json['maxPeopleCount'],
      appliedPeopleCount: json['appliedPeopleCount'],
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['date'] = date;
    data['timeStart'] = timeStart;
    data['timeEnd'] = timeEnd;
    data['location'] = location;
    data['maxPeopleCount'] = maxPeopleCount;
    data['appliedPeopleCount'] = appliedPeopleCount;
    return data;
  }
}
