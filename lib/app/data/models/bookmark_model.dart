class Bookmark {
  String title;
  String description;
  String address;

  Bookmark({
    required this.title,
    required this.description,
    required this.address});

  factory Bookmark.fromJson(Map<String, dynamic> json) {
    return Bookmark(
      title: json['title'],
      description: json['description'],
      address: json['address'],
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['title'] = title;
    data['description'] = description;
    data['address'] = address;
    return data;
  }
}
