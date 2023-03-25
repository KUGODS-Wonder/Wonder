import 'package:wonder_flutter/app/data/models/reservation_data_model.dart';

class Reservation {
  int reservationId;
  int voluntaryWorkId;
  DateTime date;
  String timeStart;
  String timeEnd;
  String location;
  int maxPeopleCount;
  int appliedPeopleCount;

  Reservation({
    required this.reservationId,
    required this.voluntaryWorkId,
    required this.date,
    required this.timeStart,
    required this.timeEnd,
    required this.location,
    required this.maxPeopleCount,
    required this.appliedPeopleCount,
  });

  factory Reservation.fromJson(Map<String, dynamic> json) {
    return Reservation(
      reservationId: json['reservationId'] ?? -1,
      voluntaryWorkId: json['voluntaryWorkId'] ?? -1,
      date: json['date'],
      timeStart: json['timeStart'],
      timeEnd: json['timeEnd'],
      location: json['location'],
      maxPeopleCount: json['maxPeopleCount'],
      appliedPeopleCount: json['appliedPeopleCount'],
    );
  }

  factory Reservation.fromData(ReservationData reservationData) {
    return Reservation(
      reservationId: reservationData.reservationId,
      voluntaryWorkId: reservationData.voluntaryWorkId,
      date: DateTime.tryParse(reservationData.startDate)!,
      timeStart: '12:00',
      timeEnd: '14:00',
      location: reservationData.specificAddress,
      maxPeopleCount: reservationData.maxPeopleNumber,
      appliedPeopleCount: reservationData.currentPeopleNumber,
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
