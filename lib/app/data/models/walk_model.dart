class Walk {
  String? name;
  String? location;
  String? theme;
  List<Tag>? tags;
  int? ratingUp;
  int? requiredWalksLeft;
  int? distance;
  int? time;
  List<Coordinate>? coordinate;

  Walk(
      {this.name,
      this.location,
      this.theme,
      this.tags,
      this.ratingUp,
      this.requiredWalksLeft,
      this.distance,
      this.time,
      this.coordinate});

  Walk.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    location = json['location'];
    theme = json['theme'];
    if (json['tags'] != null) {
      tags = <Tag>[];
      json['tags'].forEach((v) {
        tags?.add(Tag.fromJson(v));
      });
    }
    ratingUp = json['ratingUp'];
    requiredWalksLeft = json['requiredWalksLeft'];
    distance = json['distance'];
    time = json['time'];
    if (json['coordinate'] != null) {
      coordinate = <Coordinate>[];
      json['coordinate'].forEach((v) {
        coordinate?.add(Coordinate.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['name'] = name;
    data['location'] = location;
    data['theme'] = theme;
    if (tags != null) {
      data['tags'] = tags?.map((v) => v.toJson()).toList();
    }
    data['ratingUp'] = ratingUp;
    data['requiredWalksLeft'] = requiredWalksLeft;
    data['distance'] = distance;
    data['time'] = time;
    if (coordinate != null) {
      data['coordinate'] = coordinate?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Tag {
  String? name;

  Tag({this.name});

  Tag.fromJson(Map<String, dynamic> json) {
    name = json['name'];
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
      lat: json['lat'].toDouble(),
      lng: json['lng'].toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['lat'] = lat;
    data['lng'] = lng;
    return data;
  }
}
