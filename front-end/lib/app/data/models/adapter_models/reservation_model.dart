import 'package:wonder_flutter/app/data/models/adapter_models/voluntary_walk_model.dart';
import 'package:wonder_flutter/app/data/models/coordinate_model.dart';
import 'package:wonder_flutter/app/data/models/reservation_data_model.dart';
import 'package:wonder_flutter/app/data/models/tag_model.dart';

class Reservation extends VoluntaryWalk {
  int reservationId;
  int maxPeopleCount;
  int appliedPeopleCount;

  Reservation({
    required int id,
    required int voluntaryWorkId,
    required String name,
    required String location,
    required String theme,
    required String institution,
    required String specificAddress,
    required List<Tag> tags,
    required int ratingUp,
    required int distance,
    required int time,
    required List<Coordinate> coordinate,
    required this.reservationId,
    required this.maxPeopleCount,
    required this.appliedPeopleCount,
    required DateTime date,
    required String timeStart,
    required String timeEnd,
  }) : super(
          id: id,
          voluntaryWorkId: voluntaryWorkId,
          name: name,
          location: location,
          theme: theme,
          institution: institution,
          specificAddress: specificAddress,
          tags: tags,
          ratingUp: ratingUp,
          distance: distance,
          time: time,
          coordinate: coordinate,
          startDate: date,
          startTime: timeStart,
          endTime: timeEnd,
  );

  factory Reservation.fromData(ReservationData reservationData, VoluntaryWalk walk) {
    return Reservation(
      id: walk.id,
      voluntaryWorkId: walk.voluntaryWorkId,
      name: walk.name,
      location: walk.location,
      theme: walk.theme,
      institution: walk.institution,
      specificAddress: walk.specificAddress,
      tags: walk.tags,
      ratingUp: walk.ratingUp,
      distance: walk.distance,
      time: walk.time,
      coordinate: walk.coordinate,
      reservationId: reservationData.reservationId,
      maxPeopleCount: reservationData.maxPeopleNumber,
      appliedPeopleCount: reservationData.currentPeopleNumber,
      date: walk.startDate,
      timeStart: walk.startTime,
      timeEnd: walk.endTime,
    );
  }
}
