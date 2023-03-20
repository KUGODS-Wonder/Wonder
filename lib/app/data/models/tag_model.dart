class Tag {
  int tagId;
  String name;

  Tag({required this.tagId, required this.name});

  factory Tag.fromJson(Map<String, dynamic> json) {
    return Tag(
      tagId: json['tagId'] ?? 0,
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['name'] = name;
    data['tagId'] = tagId;
    return data;
  }
}