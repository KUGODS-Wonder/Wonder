class BookmarkData {
  int bookmarkId;
  int walkId;
  String title;
  String? contents;

  BookmarkData({
    required this.bookmarkId,
    required this.walkId,
    required this.title,
    this.contents});

  factory BookmarkData.fromJson(Map<String, dynamic> json) {
    return BookmarkData(
      bookmarkId: json['bookmarkId'],
      walkId: json['walkId'],
      title: json['title'],
      contents: json['contents'],
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['bookmarkId'] = bookmarkId;
    data['walkId'] = walkId;
    data['title'] = title;
    data['contents'] = contents;
    return data;
  }
}
