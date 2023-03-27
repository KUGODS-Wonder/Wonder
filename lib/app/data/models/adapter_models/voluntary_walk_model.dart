import 'package:wonder_flutter/app/data/models/adapter_models/walk_model.dart';
import 'package:wonder_flutter/app/data/models/coordinate_model.dart';
import 'package:wonder_flutter/app/data/models/tag_model.dart';
import 'package:wonder_flutter/app/data/models/voluntary_walk_data_model.dart';

class VoluntaryWalk extends Walk {
  final int voluntaryWorkId;
  final DateTime startDate;
  final String startTime;
  final String endTime;
  final String specificAddress;
  final String institution;

  VoluntaryWalk({
    required int id,
    required this.voluntaryWorkId,
    required String name,
    required String location,
    required String theme,
    required this.institution,
    required this.specificAddress,
    required List<Tag> tags,
    required int ratingUp,
    required int distance,
    required int time,
    required List<Coordinate> coordinate,
    required this.startDate,
    required this.startTime,
    required this.endTime,
  })
      : super(
      id: id,
      name: name,
      location: location,
      theme: theme,
      tags: tags,
      ratingUp: ratingUp,
      distance: distance,
      time: time,
      coordinate: coordinate
  );
  
  factory VoluntaryWalk.fromData(VoluntaryWalkData data, Walk walk) {
    return VoluntaryWalk(
        id: walk.id,
        voluntaryWorkId: data.voluntaryWorkId,
        name: walk.name,
        location: walk.location,
        theme: data.specialTheme,
        institution: data.institution,
        specificAddress: data.specificAddress,
        startDate: DateTime.tryParse(data.startDate)!,
        startTime: data.startTime,
        endTime: data.endTime,
        tags: walk.tags,
        ratingUp: walk.ratingUp,
        distance: walk.distance,
        time: walk.time,
        coordinate: walk.coordinate
    );
  }
}