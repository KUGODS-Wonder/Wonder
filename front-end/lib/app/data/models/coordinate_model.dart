class Coordinate {
  int id;
  double lat;
  double lng;

  Coordinate({required this.id, required this.lat, required this.lng});

  factory Coordinate.fromJson(Map<String, dynamic> json) {
    return Coordinate(
      id: json['id'] ?? json['intermediateLocationId'],
      lat: json['latitude'] as double,
      lng: json['longitude'] as double,
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['latitude'] = lat;
    data['longitude'] = lng;
    return data;
  }
}
