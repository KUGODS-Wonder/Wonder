import 'package:wonder_flutter/app/data/models/coordinate_model.dart';
import 'package:wonder_flutter/app/data/models/tag_model.dart';
import 'package:wonder_flutter/app/data/models/walk_data_model.dart';

class Walk {
  int id;
  String name;
  String location;
  String theme;
  List<Tag> tags;
  int ratingUp;
  int distance;
  int time;
  List<Coordinate> coordinate;

  Walk({
    required this.id,
    required this.name,
    required this.location,
    required this.theme,
    required this.tags,
    required this.ratingUp,
    required this.distance,
    required this.time,
    required this.coordinate});

  factory Walk.fromJson(Map<String, dynamic> json) {
    return Walk(
      id: json['id'],
      name: json['name'],
      location: json['location'],
      theme: json['theme'],
      tags: (json['tags'] as List).map((i) => Tag.fromJson(i)).toList(),
      ratingUp: json['ratingUp'],
      distance: json['distance'],
      time: json['time'],
      coordinate: (json['coordinate'] as List)
          .map((i) => Coordinate.fromJson(i))
          .toList(),
    );
  }

  factory Walk.fromData(WalkData data) {
    var coordinates = <Coordinate>[];
    coordinates.add(Coordinate(lat: data.originLatitude, lng: data.originLongitude, id: 0));
    coordinates.addAll(data.intermediateLocationList);
    coordinates.add(Coordinate(lat: data.destinationLatitude, lng: data.destinationLongitude, id: data.intermediateLocationList.length + 1));

    return Walk(
      id: data.walkId,
      name: data.title,
      location: data.address,
      theme: data.theme,
      tags: data.tagList,
      ratingUp: data.point,
      distance: (data.pathDistance * 1000).round(),
      time: data.requiredTime ~/ 3600,
      coordinate: coordinates,
    );
  }
}