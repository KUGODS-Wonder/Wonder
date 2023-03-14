class Walk {
  int id;
  String name;
  String location;
  String theme;
  List<Tag> tags;
  int ratingUp;
  int requiredWalksLeft;
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
    required this.requiredWalksLeft,
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
      requiredWalksLeft: json['requiredWalksLeft'],
      distance: json['distance'],
      time: json['time'],
      coordinate: (json['coordinate'] as List)
          .map((i) => Coordinate.fromJson(i))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['location'] = location;
    data['theme'] = theme;
    data['tags'] = tags.map((v) => v.toJson()).toList();
    data['ratingUp'] = ratingUp;
    data['requiredWalksLeft'] = requiredWalksLeft;
    data['distance'] = distance;
    data['time'] = time;
    data['coordinate'] = coordinate.map((v) => v.toJson()).toList();
    return data;
  }
}

class Tag {
  String name;

  Tag({required this.name});

  factory Tag.fromJson(Map<String, dynamic> json) {
    return Tag(
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['name'] = name;
    return data;
  }
}

class Coordinate {
  double lat;
  double lng;

  Coordinate({required this.lat, required this.lng});

  factory Coordinate.fromJson(Map<String, dynamic> json) {
    return Coordinate(
      lat: json['lat'] as double,
      lng: json['lng'] as double,
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['lat'] = lat;
    data['lng'] = lng;
    return data;
  }
}
