import 'package:wonder_flutter/app/data/models/coordinate_model.dart';
import 'package:wonder_flutter/app/data/models/tag_model.dart';

class WalkData {
  int walkId;
  String title;
  double pathDistance;
  int requiredTime;
  String address;
  String theme;
  double originLatitude;
  double originLongitude;
  double destinationLatitude;
  double destinationLongitude;
  int point;
  double distanceToUser;
  List<Coordinate> intermediateLocationList;
  List<Tag> tagList;

  WalkData(
      {required this.walkId,
      required this.title,
      required this.pathDistance,
      required this.requiredTime,
      required this.address,
      required this.theme,
      required this.originLatitude,
      required this.originLongitude,
      required this.destinationLatitude,
      required this.destinationLongitude,
      required this.point,
      required this.distanceToUser,
      required this.intermediateLocationList,
      required this.tagList});

  factory WalkData.fromJson(Map<String, dynamic> json) {
    return WalkData(
      walkId: json['walkId'],
      title: json['title'],
      pathDistance: json['pathDistance'],
      requiredTime: json['requiredTime'],
      address: json['address'],
      theme: json['theme'],
      originLatitude: json['originLatitude'],
      originLongitude: json['originLongitude'],
      destinationLatitude: json['destinationLatitude'],
      destinationLongitude: json['destinationLongitude'],
      point: json['point'],
      distanceToUser: json['distanceToUser'],
      intermediateLocationList: (json['intermediateLocationList'] as List)
          .map((i) => Coordinate.fromJson(i))
          .toList(),
      tagList: (json['tagList'] as List)
          .map((i) => Tag.fromJson(i))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['walkId'] = walkId;
    data['title'] = title;
    data['pathDistance'] = pathDistance;
    data['requiredTime'] = requiredTime;
    data['address'] = address;
    data['theme'] = theme;
    data['originLatitude'] = originLatitude;
    data['originLongitude'] = originLongitude;
    data['destinationLatitude'] = destinationLatitude;
    data['destinationLongitude'] = destinationLongitude;
    data['point'] = point;
    data['distanceToUser'] = distanceToUser;
    data['intermediateLocationList'] =
        intermediateLocationList.map((v) => v.toJson()).toList();
    data['tagList'] = tagList.map((v) => v.toJson()).toList();
    return data;
  }
}