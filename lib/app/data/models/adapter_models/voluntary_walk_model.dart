import 'package:wonder_flutter/app/data/models/adapter_models/walk_model.dart';
import 'package:wonder_flutter/app/data/models/coordinate_model.dart';
import 'package:wonder_flutter/app/data/models/tag_model.dart';
import 'package:wonder_flutter/app/data/models/voluntary_walk_data_model.dart';

class VoluntaryWalk extends Walk {
  VoluntaryWalk({
    required int id,
    required int voluntaryWorkId,
    required String name,
    required String location,
    required String theme,
    required String institution,
    required String specificAddress,
    required List<Tag> tags,
    required int ratingUp,
    required int requiredWalksLeft,
    required int distance,
    required int time,
    required List<Coordinate> coordinate})
      : super(
      id: id,
      name: name,
      location: location,
      theme: theme,
      tags: tags,
      ratingUp: ratingUp,
      requiredWalksLeft: requiredWalksLeft,
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
        tags: walk.tags,
        ratingUp: walk.ratingUp,
        requiredWalksLeft: walk.requiredWalksLeft,
        distance: walk.distance,
        time: walk.time,
        coordinate: walk.coordinate
    );
  }
}